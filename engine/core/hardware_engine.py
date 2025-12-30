import re
import logging

logger = logging.getLogger(__name__)

# --- GPU Architecture Performance Baselines (Base Score per Architecture) ---
GPU_ARCH_SCORES = {
    "NVIDIA": {
        "RTX 40": 10000, 
        "RTX 30": 7500,  
        "RTX 20": 5000,  
        "GTX 16": 3500,  
        "GTX 10": 3000,  
        "GTX 9": 1800,   
        "GTX 7": 1000,   
        "GTX 6": 800,    
        "GTX 5": 500,    
        "GTX 4": 300,    
        "9800": 150,     
        "INTEGRATED": 200 
    },
    "AMD": {
        "RX 7": 9500,    
        "RX 6": 7000,    
        "RX 5000": 5000, 
        "RX 5": 2500,    
        "RX 4": 2000,    
        "R9": 1500,      
        "R7": 800,       
        "HD 7": 1000,    
        "HD 6": 600,     
        "VEGA": 1200,    
        "INTEGRATED": 250 
    }
}

def get_gpu_score(name: str) -> float:
    name = (name or "").upper()
    if not name or "UNKNOWN" in name:
        return 0.0

    # Mobile/Laptop Penalty
    is_laptop = any(x in name for x in ["MOBILE", "LAPTOP", "MAX-Q", "MAX-P", " (M)", "M-SERIES"])
    
    vendor = "NVIDIA"
    if any(x in name for x in ["AMD", "RADEON", "RX"]):
        vendor = "AMD"
    elif any(x in name for x in ["INTEL", "UHD", "IRIS"]):
        vendor = "INTEL"

    # Integrated Graphics Check
    if any(x in name for x in ["INTEL HD", "UHD", "IRIS", "GRAPHICS", "INTEGRATED", "VEGA 3", "VEGA 7", "VEGA 8", "VEGA 11"]):
        score = float(GPU_ARCH_SCORES.get(vendor, {}).get("INTEGRATED", 150.0))
        if is_laptop:
            score *= 0.7
        return float(score)

    # Extract Model Number (e.g., 3060, 6800, 1050)
    model_match = re.search(r'(\d{3,4})', name)
    model_num = int(model_match.group(1)) if model_match else 0
    model_tier = (model_num % 100)
    
    # Identify Arch
    base_score = 0.0
    arch_key = ""
    
    if vendor == "NVIDIA":
        if "RTX 40" in name:
            arch_key = "RTX 40"
        elif "RTX 30" in name:
            arch_key = "RTX 30"
        elif "RTX 20" in name:
            arch_key = "RTX 20"
        elif "GTX 16" in name:
            arch_key = "GTX 16"
        elif "GTX 10" in name:
            arch_key = "GTX 10"
        elif "GTX 9" in name:
            arch_key = "GTX 9"
        elif any(x in name for x in ["GTX 7", "GT 7"]):
            arch_key = "GTX 7"
        elif "9800" in name:
            arch_key = "9800"
        
        # Fallback by model number ranges
        if not arch_key and model_num:
            if 4000 <= model_num < 5000:
                arch_key = "RTX 40"
            elif 3000 <= model_num < 4000:
                arch_key = "RTX 30"
            elif 2000 <= model_num < 3000:
                arch_key = "RTX 20"
            elif 1600 <= model_num < 1700:
                arch_key = "GTX 16"
            elif 1000 <= model_num < 1100:
                arch_key = "GTX 10"
            elif 900 <= model_num < 1000:
                arch_key = "GTX 9"
            
        base_score = float(GPU_ARCH_SCORES["NVIDIA"].get(arch_key, 500.0))
        
        # Plausibility check for fake/niche models
        if model_num and arch_key.startswith("RTX"):
            if model_tier < 50: 
                base_score *= 0.2 # Penalty for suspect models like 3040
    
    elif vendor == "AMD":
        if "RX 7" in name:
            arch_key = "RX 7"
        elif "RX 6" in name:
            arch_key = "RX 6"
        elif any(x in name for x in ["RX 5000", "RX 5700", "RX 5600"]):
            arch_key = "RX 5000"
        elif "RX 5" in name:
            arch_key = "RX 5"
        elif "RX 4" in name:
            arch_key = "RX 4"
        elif "VEGA" in name:
            arch_key = "VEGA"
        
        if not arch_key and model_num:
            if 7000 <= model_num < 8000:
                arch_key = "RX 7"
            elif 6000 <= model_num < 7000:
                arch_key = "RX 6"
            elif 5000 <= model_num < 6000:
                arch_key = "RX 5000"
            elif 500 <= model_num < 600:
                arch_key = "RX 5"
            elif 400 <= model_num < 500:
                arch_key = "RX 4"

        base_score = float(GPU_ARCH_SCORES["AMD"].get(arch_key, 400.0))

    # Multiplier
    multiplier = 1.0 + (model_tier / 100.0)
    if any(x in name for x in ["TI", "SUPER", "XT"]):
        multiplier += 0.2
        
    final_score = base_score * multiplier
    if is_laptop: 
        final_score *= 0.75
    
    if vendor == "INTEL" and arch_key == "": 
        final_score = 250.0 
    
    return float(final_score)

def get_cpu_score(name: str) -> float:
    name = (name or "").upper()
    if not name or "UNKNOWN" in name:
        return 0.0

    series_score = 300.0
    if any(x in name for x in ["I9", "RYZEN 9", "THREADRIPPER"]): 
        series_score = 1000.0
    elif any(x in name for x in ["I7", "RYZEN 7"]): 
        series_score = 800.0
    elif any(x in name for x in ["I5", "RYZEN 5"]): 
        series_score = 600.0
    elif any(x in name for x in ["I3", "RYZEN 3"]): 
        series_score = 400.0
    elif any(x in name for x in ["CORE 2", "QUAD", "PENTIUM", "ATHLON", "CELERON", "PHENOM"]): 
        series_score = 100.0

    gen = 1
    model_match = re.search(r'(\d{4,5})', name)
    if model_match:
        m = model_match.group(1)
        if len(m) == 5: 
            gen = int(m[:2])
        else: 
            gen = int(m[0])
            if "RYZEN" in name: 
                gen += 7 
    
    final_score = (series_score * 0.5) + (gen * 120.0)
    if any(x in name for x in ["MOBILE", "LAPTOP", " U ", " H ", " G7 ", " G4 "]):
        final_score *= 0.8
        
    return float(final_score)
