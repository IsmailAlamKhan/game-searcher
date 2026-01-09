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

logger = logging.getLogger("GameHunter Engine")


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

    parser = argparse.ArgumentParser(description="Game Search Engine")
    parser.add_argument(
        "--port",
        type=int,
        default=3000,
        help="Port to run the server on (default: 3000)",
    )
    parser.add_argument(
        "--host",
        type=str,
        default="127.0.0.1",
        help="Host to run the server on (default: 127.0.0.1)",
    )

    args = parser.parse_args()

    logger = logging.getLogger(__name__)
    logger.info(f"Starting server on {args.host}:{args.port}")

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
