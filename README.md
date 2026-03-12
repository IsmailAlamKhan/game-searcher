<div align="center">

<img src="logo.png" alt="GameHunter Logo" width="120" />

# GameHunter

**The ultimate game discovery and PC compatibility tool — all in one beautiful desktop app.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Python](https://img.shields.io/badge/Python-3.9+-3776AB?logo=python&logoColor=white)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-Backend-009688?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![Supabase](https://img.shields.io/badge/Supabase-Database-3ECF8E?logo=supabase&logoColor=white)](https://supabase.com)
[![Release](https://img.shields.io/badge/Release-v0.0.5-blue)](https://github.com/IsmailAlamKhan/game-searcher/releases)
[![License](https://img.shields.io/badge/License-Proprietary-red)](#license)

[🌐 Live Demo](https://game-searcher-two.vercel.app) &nbsp;·&nbsp; [📦 Releases](https://github.com/IsmailAlamKhan/game-searcher/releases) &nbsp;·&nbsp; [🐛 Report a Bug](https://github.com/IsmailAlamKhan/game-searcher/issues)

</div>

---

## Overview

**GameHunter** helps PC gamers discover new titles and instantly determine whether their machine can run them. Powered by the [RAWG.io](https://rawg.io) game database and a local Python intelligence engine, GameHunter combines rich game metadata — trailers, screenshots, store links, DLCs, and Reddit discussions — with real-time hardware compatibility analysis, wrapped in a polished cross-platform desktop UI built with Flutter.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔍 **Smart Game Search** | Search across thousands of titles with powerful filters for tags, genres, and platforms via RAWG.io |
| 🖥️ **"Can I Run It?" Check** | Instantly compare your PC's CPU, GPU, and RAM against a game's minimum and recommended requirements |
| 🏷️ **Discovery Tags** | Browse curated tag collections to find your next favourite genre or niche |
| 📋 **Detailed Insights** | Access trailers, screenshots, store links, DLC info, and live Reddit discussions for any title |
| 🤖 **AI Chat** | Ask questions about games via an integrated AI assistant powered by Supabase Edge Functions |
| 🚀 **Cross-Platform** | Fully optimised desktop builds for **Windows**, **macOS**, and **Linux** |

---

## 🏗️ Architecture

GameHunter is a monorepo with a clean separation between frontend, backend, and infrastructure:

```
game-searcher/
├── app/              # Flutter desktop frontend (Dart)
├── engine/           # Python FastAPI backend — data & compatibility logic
├── supabase/         # Supabase Edge Functions, migrations & config
├── n8n/              # n8n workflow automation (Dockerised)
├── scripts/          # Build, packaging & utility scripts
└── .github/          # CI/CD workflows
```

### Frontend — `app/`
A Flutter desktop application following a **feature-first architecture** with [Riverpod](https://riverpod.dev/) for state management. Key packages include `go_router` for navigation, `dio` for networking, and `cached_network_image` for performant image loading.

### Backend — `engine/`
A Python [FastAPI](https://fastapi.tiangolo.com/) service responsible for wrapping the RAWG API, detecting local hardware specs (CPU, GPU, RAM, OS), and running compatibility analysis against game requirements. The engine can be compiled into a standalone binary via PyInstaller or Nuitka for bundled distribution.

### Database & Functions — `supabase/`
Supabase handles persistent storage and hosts the Edge Functions that power the AI chat feature.

### Automation — `n8n/`
An n8n workflow engine (Docker-based) handles background data processing and enrichment pipelines.

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- - [Python 3.9+](https://www.python.org/downloads/)
  - - A free **RAWG API Key** → [rawg.io/apidocs](https://rawg.io/apidocs)
    - - Desktop build tools: **Visual Studio** (Windows) · **Xcode** (macOS) · **Ninja + GTK** (Linux)
     
      - ---

      ### 1. Clone the Repository

      ```bash
      git clone https://github.com/IsmailAlamKhan/game-searcher.git
      cd game-searcher
      ```

      ### 2. Set Up the Engine (Python Backend)

      ```bash
      cd engine

      # Create and activate a virtual environment
      python -m venv .venv
      source .venv/bin/activate        # macOS / Linux
      # .venv\Scripts\activate         # Windows

      # Install dependencies
      pip install -r requirements.txt

      # Configure environment variables
      echo "RAWG_API_KEY=your_rawg_api_key_here" > .env
      ```

      Start the engine server:

      ```bash
      python main.py
      ```

      The API will be live at `http://localhost:8000` with Swagger docs at `http://localhost:8000/docs`.

      ### 3. Set Up the Flutter App

      ```bash
      cd ../app

      flutter pub get
      flutter run -d windows    # or: macos | linux
      ```

      > **Note:** The app connects to the engine on `localhost:8000` by default. Ensure the engine is running before launching in development mode.
      >
      > ### 4. Build for Production
      >
      > ```bash
      > # App
      > flutter build windows   # or: macos | linux
      >
      > # Engine — see /scripts for PyInstaller / Nuitka packaging
      ```

      ---

      ## ⚙️ Configuration

      | Parameter | Location | Description |
      |---|---|---|
      | `RAWG_API_KEY` | `engine/.env` | Your RAWG.io API key |
      | Engine URL | `app/` source | Defaults to `localhost:8000` |
      | Bundle ID | `app/` | `com.ismail.gamehunter` |

      ---

      ## 🔧 Tech Stack

      **Frontend:** Flutter · Dart · Riverpod · go_router · dio · cached_network_image

      **Backend:** Python 3.9+ · FastAPI · PyInstaller / Nuitka

      **Infrastructure:** Supabase (DB + Edge Functions) · n8n (workflow automation) · RAWG.io API · GitHub Actions (CI/CD)

      ---

      ## 🤝 Contributing

      1. Fork the repository
      2. Create a feature branch: `git checkout -b feature/your-feature-name`
      3. Commit your changes: `git commit -m 'feat: add some feature'`
      4. Push to your branch: `git push origin feature/your-feature-name`
      5. Open a Pull Request

      Please ensure your code passes linting (`flake8` for Python, `flutter analyze` for Dart) before submitting.

      ---

      ## 📄 License

      Copyright © 2025 Ismail. All rights reserved.
