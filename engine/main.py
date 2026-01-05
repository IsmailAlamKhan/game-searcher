"""GameHunter Engine - Entry Point.

This module serves as the entry point for the GameHunter Engine server.
It configures logging, parses command-line arguments, and starts the Uvicorn
ASGI server to run the FastAPI application.

Usage:
    python main.py [--host HOST] [--port PORT]
"""

import argparse
import logging

import uvicorn
from core.logger import setup_logging


def main():
    """Initialize and start the GameHunter Engine server.

    Configures logging, parses command-line arguments for host and port settings,
    and starts the Uvicorn ASGI server with the FastAPI application.

    The server runs in reload mode for development, automatically restarting
    when code changes are detected.

    Command-line Args:
        --host: The host address to bind to (default: 127.0.0.1)
        --port: The port number to listen on (default: 5678)
    """
    # Setup custom logging first
    log_file = setup_logging()

    parser = argparse.ArgumentParser(description="Game Search Engine")
    parser.add_argument(
        "--port",
        type=int,
        default=5678,
        help="Port to run the server on (default: 5678)",
    )
    parser.add_argument(
        "--host",
        type=str,
        default="127.0.0.1",
        help="Host to run the server on (default: 127.0.0.1)",
    )

    args = parser.parse_args()

    # Get logger after setup_logging() has configured it
    logger = logging.getLogger(__name__)
    logger.info(f"Starting server on {args.host}:{args.port}")
    logger.info(f"Logs are being written to: {log_file}")

    try:
        # Disable uvicorn's default logging configuration to use ours
        uvicorn.run(
            "app:app",
            host=args.host,
            port=args.port,
            reload=True,
            # log_config=None,  # This prevents uvicorn from overriding our logging
            access_log=True,  # Still log access requests
        )
    except Exception as e:
        logger.error(f"Failed to start server: {e}", exc_info=True)


if __name__ == "__main__":
    main()
