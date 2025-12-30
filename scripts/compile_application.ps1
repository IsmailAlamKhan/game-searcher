# Script to compile the Python engine using Nuitka

$ErrorActionPreference = "Stop"

$SCRIPT_DIR = $PSScriptRoot
$PROJECT_ROOT = Split-Path $SCRIPT_DIR -Parent
$ENGINE_DIR = Join-Path $PROJECT_ROOT "engine"
$APP_DIR = Join-Path $PROJECT_ROOT "app"
$BUILD_DIR = Join-Path $APP_DIR "build/windows/x64/runner/Release/data/engine"
$TEMP_BUILD_DIR = Join-Path $APP_DIR "build/temp"

Write-Host "Compiling Application..."
Write-Host "Project Root: $PROJECT_ROOT"
Write-Host "Engine Dir: $ENGINE_DIR"
Write-Host "App Dir: $APP_DIR"
Write-Host "Output Dir for Engine: $BUILD_DIR"

Write-Host "Compiling App..."
Push-Location $APP_DIR
flutter build windows
Pop-Location
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to build app."
    exit $LASTEXITCODE
}

Write-Host "Compiling Engine..."
# Ensure output directory exists (and clean it if you want a fresh build)
if (Test-Path $TEMP_BUILD_DIR) {
    Remove-Item -Path $TEMP_BUILD_DIR -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $TEMP_BUILD_DIR | Out-Null

if (Test-Path $BUILD_DIR) {
    Remove-Item -Path $BUILD_DIR -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $BUILD_DIR | Out-Null

Push-Location $ENGINE_DIR

Write-Host "Generating secrets..."
python "$PROJECT_ROOT/scripts/generate_secrets.py"

Write-Host "Installing/Updating Nuitka..."
pip install nuitka
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to install Nuitka."
}

Write-Host "Running Nuitka..."
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

Copy-Item -Path "$TEMP_BUILD_DIR/main.dist/*" -Destination "$BUILD_DIR" -Recurse


Write-Host "Compilation Complete!"

# Start-Process "$BUILD_DIR/main.dist/game_search_engine.exe"
