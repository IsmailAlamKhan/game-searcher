import os
import subprocess
import sys
from pathlib import Path


def install_pillow():
    try:
        import PIL

        print("Pillow is already installed.")
    except ImportError:
        print("Installing Pillow...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "Pillow"])


install_pillow()

from PIL import Image


def generate_icons():
    source_path = Path("logo.png")
    if not source_path.exists():
        print(f"Error: {source_path} not found.")
        return

    # Windows Icon
    # Needs to be in app/windows/runner/resources/app_icon.ico
    win_icon_path = Path("app/windows/runner/resources/app_icon.ico")
    if not win_icon_path.parent.exists():
        print(f"Error: {win_icon_path.parent} not found.")
        return

    print("Generating Windows icon...")
    img = Image.open(source_path)
    # Windows icons usually include 16, 32, 48, 256
    img.save(
        win_icon_path, format="ICO", sizes=[(16, 16), (32, 32), (48, 48), (256, 256)]
    )
    print(f"Saved {win_icon_path}")

    # macOS Icons
    # app/macos/Runner/Assets.xcassets/AppIcon.appiconset/
    # Sizes: 16, 32, 64, 128, 256, 512, 1024
    mac_icon_dir = Path("app/macos/Runner/Assets.xcassets/AppIcon.appiconset")
    if not mac_icon_dir.exists():
        print(f"Error: {mac_icon_dir} not found.")
        return

    print("Generating macOS icons...")
    sizes = [16, 32, 64, 128, 256, 512, 1024]
    for size in sizes:
        resized_img = img.resize((size, size), Image.Resampling.LANCZOS)
        filename = f"app_icon_{size}.png"
        output_path = mac_icon_dir / filename
        resized_img.save(output_path)
        print(f"Saved {output_path}")

    print("Icon generation complete.")


if __name__ == "__main__":
    generate_icons()
