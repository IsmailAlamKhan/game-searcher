"""GameHunter Engine - System Information Gathering.

This module provides utilities for detecting and collecting hardware specifications
from the current system. Used primarily for the game compatibility checker feature.

Supports Windows, macOS, and Linux with platform-specific detection methods and fallbacks.

Functions:
    get_cpu_info: Detect CPU/processor name
    get_ram_info: Detect total RAM in GB
    get_gpu_info: Detect GPU/graphics card name
    get_disk_info: Detect available disk space in GB
    get_system_specs: Collect all system specifications
"""

import os
import platform
import re
import subprocess


def get_cpu_info():
    """Get the CPU/processor name.

    Attempts to detect the CPU name using py-cpuinfo library, falling back
    to platform-specific WMI commands on Windows.

    Returns:
        str: CPU name/model, or "Unknown CPU" if detection fails.
    """
    try:
        import cpuinfo

        info = cpuinfo.get_cpu_info()
        return info.get("brand_raw", "Unknown CPU")
    except Exception:
        if platform.system() == "Windows":
            try:
                output = subprocess.check_output(
                    "wmic cpu get name", shell=True
                ).decode()
                lines = [
                    line.strip()
                    for line in output.split("\n")
                    if line.strip() and "Name" not in line
                ]
                return lines[0] if lines else "Unknown CPU"
            except Exception:
                pass
        return "Unknown CPU"


def get_ram_info():
    """Get the total system RAM in gigabytes.

    Attempts to detect RAM using psutil library, falling back to
    platform-specific WMI commands on Windows.

    Returns:
        int: Total RAM in GB (rounded), or 0 if detection fails.
    """
    try:
        import psutil

        ram = psutil.virtual_memory()
        return round(ram.total / (1024**3))
    except Exception:
        if platform.system() == "Windows":
            try:
                output = subprocess.check_output(
                    "wmic ComputerSystem get TotalPhysicalMemory", shell=True
                ).decode()
                match = re.search(r"\d+", output)
                if match:
                    return round(int(match.group()) / (1024**3))
            except Exception:
                pass
    return 0


def get_gpu_info():
    """Get the GPU/graphics card name.

    Detects the GPU using PowerShell or WMI on Windows. If multiple GPUs are detected,
    prioritizes dedicated GPUs (NVIDIA/AMD) over integrated graphics.

    Returns:
        str: GPU name/model, or "Unknown GPU" if detection fails.

    Note:
        For systems with multiple GPUs, returns the first dedicated GPU if available,
        otherwise returns the first detected GPU.
    """
    if platform.system() == "Windows":
        gpus = []
        try:
            # Use PowerShell with -NoProfile and silence stderr to avoid noise
            cmd = 'powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"'
            output = (
                subprocess.check_output(cmd, shell=True, stderr=subprocess.DEVNULL)
                .decode()
                .strip()
            )

            for line in output.split("\n"):
                line = line.strip()
                if not line or any(
                    x in line for x in ["Set-PSReadLineOption", "virtual terminal"]
                ):
                    continue
                gpus.append(line)
        except Exception:
            try:
                output = subprocess.check_output(
                    "wmic path win32_VideoController get name", shell=True
                ).decode()
                lines = [
                    line.strip()
                    for line in output.split("\n")
                    if line.strip() and "Name" not in line
                ]
                gpus.extend(lines)
            except Exception:
                pass

        if gpus:
            # Pick the "best" GPU if multiple are found
            # Simple heuristic: dedicated (RTX, GTX, RX) > integrated (Graphics, Intel HD, Vega)
            dedicated = [
                g
                for g in gpus
                if any(
                    x in g.upper() for x in ["RTX", "GTX", "RX ", "RADEON RX", "QUADRO"]
                )
            ]
            if dedicated:
                return dedicated[0]
            # Next best: any Radeon that isn't just "Graphics"
            radeon = [
                g
                for g in gpus
                if "RADEON" in g.upper() and g.upper() != "AMD RADEON(TM) GRAPHICS"
            ]
            if radeon:
                return radeon[0]
            return gpus[0]

    return "Unknown GPU"


def get_disk_info():
    """Get available disk space in gigabytes.

    Attempts to get free space using psutil library, falling back to
    platform-specific WMI commands on Windows (defaults to C: drive).

    Returns:
        int: Free disk space in GB (rounded), or 0 if detection fails.
    """
    try:
        import psutil

        path = os.getcwd()
        usage = psutil.disk_usage(path)
        return round(usage.free / (1024**3))
    except Exception:
        if platform.system() == "Windows":
            try:
                output = subprocess.check_output(
                    "wmic logicaldisk where \"DeviceID='C:'\" get freespace", shell=True
                ).decode()
                match = re.search(r"\d+", output)
                if match:
                    return round(int(match.group()) / (1024**3))
            except Exception:
                pass
    return 0


def get_system_specs():
    """Collect all system specifications.

    Gathers CPU, RAM, GPU, and disk information into a single dictionary.
    This is the primary function used by the compatibility checker.

    Returns:
        dict: System specifications with keys:
            - cpu (str): Processor name
            - ram (int): Total RAM in GB
            - gpu (str): Graphics card name
            - disk_free (int): Available disk space in GB
    """
    return {
        "cpu": get_cpu_info(),
        "ram": get_ram_info(),
        "gpu": get_gpu_info(),
        "disk_free": get_disk_info(),
    }
