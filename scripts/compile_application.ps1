# Script to compile the Python engine using Nuitka

$ErrorActionPreference = "Stop"

$SCRIPT_DIR = $PSScriptRoot
$PROJECT_ROOT = Split-Path $SCRIPT_DIR -Parent
$ENGINE_DIR = Join-Path $PROJECT_ROOT "engine"
$APP_DIR = Join-Path $PROJECT_ROOT "app"
$BUILD_DIR = Join-Path $APP_DIR "build/windows/x64/runner/Release/data/engine"
$TEMP_BUILD_DIR = Join-Path $APP_DIR "build/temp"
$SETUP_SCRIPT = Join-Path $SCRIPT_DIR "setup_script.iss"

function Log-Step {
    param (
        [string]$Message
    )
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$Timestamp] $Message" -ForegroundColor Cyan
}

Log-Step "Starting Compilation Process..."
Log-Step "Project Root: $PROJECT_ROOT"
Log-Step "Engine Dir: $ENGINE_DIR"
Log-Step "App Dir: $APP_DIR"
Log-Step "Output Dir for Engine: $BUILD_DIR"

Log-Step "Compiling App..."
Push-Location $APP_DIR
flutter build windows
Pop-Location
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to build app."
    exit $LASTEXITCODE
}

Log-Step "Compiling Engine..."
# Ensure output directory exists (and clean it if you want a fresh build)
if (Test-Path $TEMP_BUILD_DIR) {
    Log-Step "Cleaning temp build dir..."
    Remove-Item -Path $TEMP_BUILD_DIR -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $TEMP_BUILD_DIR | Out-Null

if (Test-Path $BUILD_DIR) {
    Log-Step "Cleaning engine build dir..."
    Remove-Item -Path $BUILD_DIR -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $BUILD_DIR | Out-Null

Push-Location $ENGINE_DIR

Log-Step "Generating secrets..."
python "$PROJECT_ROOT/scripts/generate_secrets.py"

Log-Step "Installing/Updating Nuitka..."
pip install nuitka
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to install Nuitka."
}

Log-Step "Running Nuitka..."
python -m nuitka `
    --standalone `
    --include-data-dir=ai=ai `
    --include-package=uvicorn `
    --include-package=fastapi `
    --output-dir="$TEMP_BUILD_DIR" `
    --output-filename="game_search_engine.exe" `
    --quiet `
    --assume-yes-for-downloads `
    main.py

Pop-Location

Log-Step "Copying engine files to build directory..."
Copy-Item -Path "$TEMP_BUILD_DIR/main.dist/*" -Destination "$BUILD_DIR" -Recurse

Log-Step "App and Engine Compilation Complete!"

Log-Step "Compiling Installer..."
if (Test-Path $SETUP_SCRIPT) {
    if (Get-Command "iscc" -ErrorAction SilentlyContinue) {
        $ISCCArgs = "/Q" # Quiet mode
        try {
            Start-Process -FilePath "iscc" -ArgumentList "`"$SETUP_SCRIPT`" $ISCCArgs" -Wait -NoNewWindow
            Log-Step "Installer compiled successfully."
        } catch {
             Write-Error "Failed to compile installer: $_"
        }
    } else {
        Write-Warning "Inno Setup Compiler (iscc) not found. Skipping installer compilation."
    }
} else {
    Write-Error "Setup script not found at $SETUP_SCRIPT"
}

Log-Step "All tasks completed successfully."
