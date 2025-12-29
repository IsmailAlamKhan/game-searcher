import argparse
import uvicorn


from core.logger import setup_logging

def main():
    setup_logging()
    parser = argparse.ArgumentParser(description="Game List Scraper Engine")
    parser = argparse.ArgumentParser(description="Game Search Engine")
    parser.add_argument('--port', type=int, default=5678, help="Port to run the server on (default: 5678)")
    parser.add_argument('--host', type=str, default="127.0.0.1", help="Host to run the server on (default: 127.0.0.1)")
    
    args = parser.parse_args()
    
    print(f"Starting server on {args.host}:{args.port}")
    # Use string "app:app" to enable reload
    uvicorn.run("app:app", host=args.host, port=args.port, reload=True)


if __name__ == "__main__":
    main()
