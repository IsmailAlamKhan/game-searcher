"""GameHunter Engine - Hardware Scoring System.

This module provides heuristic-based scoring algorithms for CPUs and GPUs to enable
comparative performance analysis. Used by the compatibility checker to determine if
user hardware meets game requirements.

The scoring system uses architecture-based baseline scores with modifiers for:
- Model tier (e.g., x060 vs x080)
- Special variants (Ti, Super, XT)
- Mobile/laptop penalties
- Generation-based scoring for CPUs

Note:
    Scores are relative heuristics, not benchmarks. They provide rough comparisons
    for compatibility checking but should not be used for precise performance prediction.
"""

import logging
import re

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
        "INTEGRATED": 200,
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
        "INTEGRATED": 250,
    },
}


def get_gpu_score(name: str) -> float:
    """Calculate a heuristic performance score for a GPU.

    Assigns a performance score based on GPU model, architecture, and variant.
    The algorithm identifies the vendor, architecture generation, and model tier
    to calculate a relative performance score.

    Algorithm:
        1. Detect vendor (NVIDIA, AMD, Intel)
        2. Identify architecture (RTX 40, RX 7000, etc.)
        3. Extract model number and tier
        4. Apply multipliers for variants (Ti, Super, XT)
        5. Apply laptop/mobile penalty if applicable

    Args:
        name: GPU name string (e.g., "NVIDIA GeForce RTX 3060 Ti").

    Returns:
        float: Heuristic performance score. Higher is better.
            Typical ranges:
            - Integrated graphics: 150-300
            - Budget GPUs: 500-2000
            - Mid-range GPUs: 2000-5000
            - High-end GPUs: 5000-10000+

    Examples:
        >>> get_gpu_score("NVIDIA GeForce RTX 3060")
        8250.0
        >>> get_gpu_score("AMD Radeon RX 6800 XT")
        9240.0
        >>> get_gpu_score("Intel UHD Graphics 630")
        200.0
    """
    name = (name or "").upper()
    if not name or "UNKNOWN" in name:
        return 0.0

    # Mobile/Laptop Penalty
    is_laptop = any(
        x in name for x in ["MOBILE", "LAPTOP", "MAX-Q", "MAX-P", " (M)", "M-SERIES"]
    )

    vendor = "NVIDIA"
    if any(x in name for x in ["AMD", "RADEON", "RX"]):
        vendor = "AMD"
    elif any(x in name for x in ["INTEL", "UHD", "IRIS"]):
        vendor = "INTEL"

    # Integrated Graphics Check
    if any(
        x in name
        for x in [
            "INTEL HD",
            "UHD",
            "IRIS",
            "GRAPHICS",
            "INTEGRATED",
            "VEGA 3",
            "VEGA 7",
            "VEGA 8",
            "VEGA 11",
        ]
    ):
        score = float(GPU_ARCH_SCORES.get(vendor, {}).get("INTEGRATED", 150.0))
        if is_laptop:
            score *= 0.7
        return float(score)

    # Extract Model Number (e.g., 3060, 6800, 1050)
    model_match = re.search(r"(\d{3,4})", name)
    model_num = int(model_match.group(1)) if model_match else 0
    model_tier = model_num % 100

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
                base_score *= 0.2  # Penalty for suspect models like 3040

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
    """Calculate a heuristic performance score for a CPU.

    Assigns a performance score based on CPU series (i3/i5/i7/i9 or Ryzen equivalent)
    and generation. The score combines series-based baseline with generation multipliers.

    Algorithm:
        1. Identify CPU series (i9/Ryzen 9, i7/Ryzen 7, etc.)
        2. Extract generation from model number
        3. Calculate score: (series_score * 0.5) + (generation * 120)
        4. Apply laptop/mobile penalty if applicable

    Args:
        name: CPU name string (e.g., "Intel Core i7-10700K").

    Returns:
        float: Heuristic performance score. Higher is better.
            Typical ranges:
            - Celeron/Pentium: 100-300
            - i3/Ryzen 3: 400-800
            - i5/Ryzen 5: 600-1200
            - i7/Ryzen 7: 800-1600
            - i9/Ryzen 9: 1000-2000+

    Examples:
        >>> get_cpu_score("Intel Core i7-10700K")
        1600.0
        >>> get_cpu_score("AMD Ryzen 7 5800X")
        1840.0
    """
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
    elif any(
        x in name for x in ["CORE 2", "QUAD", "PENTIUM", "ATHLON", "CELERON", "PHENOM"]
    ):
        series_score = 100.0

    gen = 1
    model_match = re.search(r"(\d{4,5})", name)
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
