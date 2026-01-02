# GameHunter Engine

The intelligent Python backend for **GameHunter**, powered by **FastAPI**. It handles game data aggregation from RAWG and performs local hardware compatibility checks.

## Features

- **Game Data API**: Wrapper around RAWG API for optimized searching.
- **Hardware Detection**: Local system specification extraction (CPU, GPU, RAM, OS).
- **Compatibility Analysis**: Logic to compare user specs vs. game requirements.

## Setup

### 1. Environment

Create a virtual environment:

```bash
python -m venv .venv
source .venv/bin/activate  # macOS/Linux
# or
.venv\Scripts\activate     # Windows
```

### 2. Dependencies

Install required packages:

```bash
pip install -r requirements.txt
```

### 3. Configuration

Create a `.env` file in this directory with your API keys:

```ini
RAWG_API_KEY=your_rawg_api_key_here
```

### 4. Running

Start the engine server:

```bash
python main.py
```

The API will be available at `http://localhost:8000`.
Documentation (Swagger UI) at `http://localhost:8000/docs`.

## Building

The engine can be compiled into a standalone executable using the build scripts in the root `scripts/` directory, typically using PyInstaller or Nuitka.
