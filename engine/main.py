import argparse
import logging

import uvicorn
from core.logger import setup_logging


def main():
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
