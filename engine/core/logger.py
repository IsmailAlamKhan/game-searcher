"""GameHunter Engine - Logging Configuration.

This module provides centralized logging configuration for the GameHunter Engine.
Logs are written to both console (stderr) and daily rotating log files organized
by date in the application data directory.

Log Structure:
    Windows: %APPDATA%/GameSearch Studio/logs/YYYY/MM/DD/service.log
    macOS: ~/Library/Application Support/GameSearch Studio/logs/YYYY/MM/DD/service.log
    Linux: ~/.local/share/GameSearch Studio/logs/YYYY/MM/DD/service.log
"""

import logging
import os
import platform
import sys
from datetime import datetime
from pathlib import Path


def get_app_data_dir(app_name: str) -> Path:
    r"""Get the platform-specific application data directory.

    Returns the appropriate application data directory for the current operating system.

    Args:
        app_name: Name of the application (used as subdirectory name).

    Returns:
        Path: Platform-specific application data directory path.

    Examples:
        Windows: C:\Users\Username\AppData\Roaming\GameSearch Studio
        macOS: /Users/Username/Library/Application Support/GameSearch Studio
        Linux: /home/username/.local/share/GameSearch Studio
    """
    system = platform.system()

    if system == "Windows":
        # %APPDATA%
        base_path = os.getenv("APPDATA")
        if not base_path:
            base_path = os.path.expanduser("~\\AppData\\Roaming")
        return Path(base_path) / app_name

    elif system == "Darwin":
        # ~/Library/Application Support
        return Path.home() / "Library" / "Application Support" / app_name

    else:
        # Linux/Unix: ~/.local/share or XDG_DATA_HOME
        xdg_data = os.getenv("XDG_DATA_HOME")
        if xdg_data:
            return Path(xdg_data) / app_name
        return Path.home() / ".local" / "share" / app_name


def setup_logging(app_name: str = "GameSearch Studio"):
    """Configure application-wide logging to file and console.

    Sets up dual logging handlers: one for file output with detailed formatting,
    and one for console output with simplified formatting. Log files are organized
    in a daily folder structure for easy navigation and cleanup.

    Args:
        app_name: Application name for the log directory (default: "GameSearch Studio").

    Returns:
        Path: Path to the created log file.

    Note:
        This function is idempotent - calling it multiple times will reset handlers
        and reconfigure logging without creating duplicates.

    Example:
        >>> log_file = setup_logging()
        >>> import logging
        >>> logging.info("Server started")
    """
    now = datetime.now()
    app_data_dir = get_app_data_dir(app_name)

    # Structure: logs/YYYY/MM/DD
    log_dir = (
        app_data_dir / "logs" / f"{now.year}" / f"{now.month:02d}" / f"{now.day:02d}"
    )
    log_dir.mkdir(parents=True, exist_ok=True)

    log_file = log_dir / "service.log"

    # Formatters
    file_formatter = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    )
    console_formatter = logging.Formatter("%(levelname)s: %(message)s")

    # Root logger
    root_logger = logging.getLogger()
    root_logger.setLevel(logging.INFO)

    # Remove existing handlers to avoid duplicates (idempotency)
    if root_logger.hasHandlers():
        root_logger.handlers.clear()

    # File Handler
    file_handler = logging.FileHandler(log_file, encoding="utf-8")
    file_handler.setFormatter(file_formatter)
    root_logger.addHandler(file_handler)

    # Console Handler
    console_handler = logging.StreamHandler(sys.stderr)
    console_handler.setFormatter(console_formatter)
    root_logger.addHandler(console_handler)

    logging.info(f"Logging initialized. Log file: {log_file}")
    return log_file
