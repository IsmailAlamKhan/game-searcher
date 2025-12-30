import re
import logging
from typing import Dict, Any, Optional
from core.hardware_engine import get_cpu_score, get_gpu_score

logger = logging.getLogger(__name__)

_KEY_MAP = {
    "OS": ["OS", "Windows"],
    "Processor": ["Processor", "CPU"],
    "Memory": ["Memory", "RAM"],
    "Graphics": ["Graphics", "Video Card", "GPU"],
    "DirectX": ["DirectX"],
    "Storage": ["Storage", "Hard Disk Space", "Hard Drive", "Space"],
    "Sound Card": ["Sound Card"],
}

def extract_requirements(text: str) -> Dict[str, str]:
    if not text:
        return {}
    specs = {}
    remaining = text
    remaining = re.sub(r'^(Minimum|Recommended):', '', remaining, flags=re.IGNORECASE).strip()
    all_keys = []
    for k, aliases in _KEY_MAP.items():
        all_keys.extend(aliases)
    all_keys.sort(key=len, reverse=True)
    pattern = '|'.join([re.escape(k) + r':' for k in all_keys])
    regex = re.compile(f'({pattern})', re.IGNORECASE)
    matches = list(regex.finditer(remaining))
    if not matches:
        return {"General": remaining}
    for i in range(len(matches)):
        match = matches[i]
        raw_key = match.group(1).rstrip(':').strip()
        normalized_key = raw_key
        for k, aliases in _KEY_MAP.items():
            if any(raw_key.lower() == alias.lower() for alias in aliases):
                normalized_key = k
                break
        start = match.end()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(remaining)
        value = remaining[start:end].strip()
        # Clean up common debris like \r\n, trailing punctuation, or leaked prefixes
        value = re.sub(r'[\r\n]+', ' ', value)
        value = re.sub(r'^[\s\-\,]+|[\s\-\,]+$', '', value)
        # Remove trailing single words that look like labels
        value = re.sub(r'\s+[A-Z]{1,2}$', '', value)
        
        if normalized_key in specs:
            specs[normalized_key] = f"{specs[normalized_key]} / {value}"
        else:
            specs[normalized_key] = value
    return specs

def parse_requirement_value(text: str, pattern: str, default: float = 0) -> float:
    if not text:
        return default
    match = re.search(pattern, text, re.IGNORECASE)
    if match:
        try:
            val = float(match.group(1))
            unit = match.group(2).upper() if len(match.groups()) > 1 else "GB"
            if unit == "MB":
                return val / 1024
            return val
        except ValueError:
            pass
    return default

def check_compatibility(user_specs: Dict[str, Any], requirements: Dict[str, Optional[str]]) -> Dict[str, Any]:
    results = {"overall": "Passed", "details": {}, "warnings": []}
    min_req_str = requirements.get("minimum", "")
    rec_req_str = requirements.get("recommended", "")
    if not min_req_str and not rec_req_str:
        return {"overall": "Unknown", "details": {}, "warnings": ["No requirements found."]}

    min_p = extract_requirements(min_req_str)
    rec_p = extract_requirements(rec_req_str)

    # --- RAM ---
    ram_pat = r'(\d+(?:\.\d+)?)\s*(GB|MB)\s*RAM'
    min_ram = parse_requirement_value(min_p.get("Memory", "") or min_req_str, ram_pat)
    rec_ram = parse_requirement_value(rec_p.get("Memory", "") or rec_req_str, ram_pat)
    u_ram = user_specs.get("ram", 0)
    
    ram_status = "Passed"
    ram_msg = "Your RAM meets the requirements."
    if u_ram < min_ram:
        ram_status = "Failed"
        ram_msg = f"Insufficient RAM. Game requires {min_ram} GB, you have {u_ram} GB."
        results["overall"] = "Failed"
    elif rec_ram > 0:
        if u_ram >= rec_ram * 1.5:
            ram_msg = "You have plenty of RAM for this game and heavy multi-tasking!"
        elif u_ram >= rec_ram:
            ram_status = "Passed"
            ram_msg = "Your RAM meets the recommended specifications for a smooth experience."
        elif u_ram >= min_ram:
            ram_status = "Minimum Met"
            ram_msg = "Meets minimum specs, but more RAM is recommended for better performance."
    elif u_ram >= min_ram:
        ram_status = "Passed"
        ram_msg = "Your RAM is more than enough for this game."

    results["details"]["ram"] = {
        "user": f"{u_ram} GB", 
        "requirement": f"{min_ram} GB", 
        "status": ram_status,
        "message": ram_msg
    }

    # --- Disk ---
    disk_pat = r'(\d+(?:\.\d+)?)\s*(GB|MB)\s*(?:available|free|storage|space|hard drive)'
    min_disk = parse_requirement_value(min_p.get("Storage", "") or min_req_str, disk_pat)
    
    disk_status = "Passed"
    disk_msg = "Please ensure you have enough space on your preferred installation drive."
        
    results["details"]["disk"] = {
        "user": "Space Needed",
        "requirement": f"{min_disk} GB", 
        "status": disk_status,
        "message": disk_msg
    }

    # --- CPU & GPU Scoring Logic ---
    def get_comp_status(u_score, m_score, r_score, comp_type="GPU"):
        if u_score == 0 or m_score == 0:
            return "Check Manually", "Hardware not recognized for automatic scoring."
            
        # If user score is powerhouse (>1.5x of recommended or 2x of min)
        target = r_score if r_score > 0 else m_score * 1.5
        if u_score >= target * 1.5:
            return "Passed", f"Your {comp_type} is a powerhouse! It's more than enough for this game."

        # If user score is clearly higher than min (>1.1x)
        if u_score >= m_score * 1.1:
            if r_score > 0 and u_score < r_score * 0.9:
                return "Minimum Met", "Meets minimum requirements, but below recommended performance."
            return "Passed", f"Your {comp_type} exceeds the required performance."
            
        # If user score is close to min (0.9x to 1.1x)
        if u_score >= m_score * 0.9:
            return "Minimum Met", "Meets minimum requirements, but performance may be marginal."
            
        # If user score is clearly below min (<0.7x)
        if u_score < m_score * 0.7:
            return "Failed", f"Your {comp_type} is significantly below the required power level."
            
        return "Check Manually", "Performance is on the border; may struggle at low settings."

    # CPU Check
    u_cpu = user_specs.get("cpu", "Unknown")
    m_cpu_req = min_p.get("Processor", "N/A")
    r_cpu_req = rec_p.get("Processor", "N/A")
    u_c_score = get_cpu_score(u_cpu)
    m_c_score = get_cpu_score(m_cpu_req)
    r_c_score = get_cpu_score(r_cpu_req)
    
    c_status, c_msg = get_comp_status(u_c_score, m_c_score, r_c_score, "CPU")
    if c_status == "Failed":
        results["overall"] = "Failed"
    results["details"]["cpu"] = {
        "user": u_cpu, 
        "requirement": m_cpu_req, 
        "status": c_status,
        "message": c_msg
    }

    # GPU Check
    u_gpu = user_specs.get("gpu", "Unknown")
    m_gpu_req = min_p.get("Graphics", "N/A")
    r_gpu_req = rec_p.get("Graphics", "N/A")
    u_g_score = get_gpu_score(u_gpu)
    m_g_score = get_gpu_score(m_gpu_req)
    r_g_score = get_gpu_score(r_gpu_req)
    
    g_status, g_msg = get_comp_status(u_g_score, m_g_score, r_g_score, "GPU")
    if g_status == "Failed":
        results["overall"] = "Failed"
    # Special message for integrated graphics if game requires powerful discrete GPU
    if "UHD" in u_gpu.upper() or "IRIS" in u_gpu.upper() or "INTEGRATED" in u_gpu.upper():
        if m_g_score > 800: # High threshold for discrete required
            g_msg = "Integrated graphics are usually not suitable for modern high-end gaming."

    results["details"]["gpu"] = {
        "user": u_gpu, 
        "requirement": m_gpu_req, 
        "status": g_status,
        "message": g_msg
    }

    # Final Overall Cleanup
    if results["overall"] == "Passed":
        statuses = [d["status"] for d in results["details"].values()]
        if any(s == "Minimum Met" for s in statuses):
            results["overall"] = "Minimum Met"
        elif any(s in ["Might Struggle", "Check Manually"] for s in statuses):
            results["overall"] = "Limited"

    # --- Predicted Preset Logic ---
    if results["overall"] == "Failed":
        results["predicted_preset"] = "N/A"
    else:
        # GPU is the main factor for presets.
        # We compare against recommended if available, otherwise minimum.
        target_gpu_score = r_g_score if r_g_score > 0 else m_g_score
        if target_gpu_score > 0:
            ratio = u_g_score / target_gpu_score
            if r_g_score > 0:
                if ratio >= 1.4:
                    results["predicted_preset"] = "Ultra"
                elif ratio >= 0.9:
                    results["predicted_preset"] = "High"
                elif ratio >= 0.6:
                    results["predicted_preset"] = "Medium"
                else:
                    results["predicted_preset"] = "Low"
            else:
                # No recommended spec, only minimum
                if ratio >= 2.0:
                    results["predicted_preset"] = "High"
                elif ratio >= 1.3:
                    results["predicted_preset"] = "Medium"
                else:
                    results["predicted_preset"] = "Low"
        else:
            results["predicted_preset"] = "Unknown"

    return results

def get_compatibility_checker():
    return check_compatibility
