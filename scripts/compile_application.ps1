$ErrorActionPreference = "Stop"

$SCRIPT_DIR = $PSScriptRoot
$PROJECT_ROOT = Split-Path $SCRIPT_DIR -Parent
$APP_DIR = Join-Path $PROJECT_ROOT "app"
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
Log-Step "App Dir: $APP_DIR"

Log-Step "Compiling App..."
Push-Location $APP_DIR
flutter build windows
Pop-Location
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to build app."
    exit $LASTEXITCODE
}

Log-Step "App Compilation Complete!"

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
