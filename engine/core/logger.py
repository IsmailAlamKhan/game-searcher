import sys
import os
import platform
import logging
from datetime import datetime
from pathlib import Path

def get_app_data_dir(app_name: str) -> Path:
    """
    Get the application data directory for the current platform.
    """
    system = platform.system()
    
    if system == "Windows":
        # %APPDATA%
        base_path = os.getenv('APPDATA')
        if not base_path:
            base_path = os.path.expanduser("~\\AppData\\Roaming")
        return Path(base_path) / app_name
        
    elif system == "Darwin":
        # ~/Library/Application Support
        return Path.home() / "Library" / "Application Support" / app_name
        
    else:
        # Linux/Unix: ~/.local/share or XDG_DATA_HOME
        xdg_data = os.getenv('XDG_DATA_HOME')
        if xdg_data:
            return Path(xdg_data) / app_name
        return Path.home() / ".local" / "share" / app_name

def setup_logging(app_name: str = "GameSearch Studio"):
    """
    Configure logging to file and console.
    Structure: AppData/AppName/logs/YYYY/MM/DD/service.log
    """
    now = datetime.now()
    app_data_dir = get_app_data_dir(app_name)
    
    # Structure: logs/YYYY/MM/DD
    log_dir = app_data_dir / "logs" / f"{now.year}" / f"{now.month:02d}" / f"{now.day:02d}"
    log_dir.mkdir(parents=True, exist_ok=True)
    
    log_file = log_dir / "service.log"
    
    # Formatters
    file_formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    console_formatter = logging.Formatter(
        '%(levelname)s: %(message)s'
    )
    
    # Root logger
    root_logger = logging.getLogger()
    root_logger.setLevel(logging.INFO)
    
    # Remove existing handlers to avoid duplicates (idempotency)
    if root_logger.hasHandlers():
        root_logger.handlers.clear()
    
    # File Handler
    file_handler = logging.FileHandler(log_file, encoding='utf-8')
    file_handler.setFormatter(file_formatter)
    root_logger.addHandler(file_handler)
    
    # Console Handler
    console_handler = logging.StreamHandler(sys.stderr)
    console_handler.setFormatter(console_formatter)
    root_logger.addHandler(console_handler)
    
    logging.info(f"Logging initialized. Log file: {log_file}")
    return log_file
