import json
import os
import re


class Version:
    version_number: str
    change_log: str


# Script to update the version of the app
VERSION_JSON = "version.json"
PUBSPEC_YAML = "app/pubspec.yaml"
SETUP_SCRIPT = "scripts/setup_script.iss"


# Gets the version from the version.json file if it exists
def get_current_version_if_exists():
    version = Version()
    if os.path.exists(VERSION_JSON):
        with open(VERSION_JSON, "r") as f:
            data = f.read()
            if data != "":
                _version = json.loads(data)
                version.version_number = _version["version_number"]
                version.change_log = _version["change_log"]
                print(f"Current version is {version.version_number}")
                return version

    version = Version()
    version.version_number = "0.0.1"
    version.change_log = "Initial release"
    print("Version file does not exist creating a new one")
    return version


def update_version(
    manual_version_number: str = None,
):
    version = get_current_version_if_exists()
    version_number = version.version_number
    version_parts = version_number.split(".")
    # If auto only update the last
    if manual_version_number:
        version_number = manual_version_number
    else:
        version_parts = bump_version(version_parts)
        version_number = ".".join(version_parts)
    version.version_number = version_number
    with open(VERSION_JSON, "w") as f:
        json.dump(version.__dict__, f, indent=4)
    update_pubspec(version_number)
    update_setup_script(version_number)
    print(f"Updated version to {version.version_number}")


def update_pubspec(version_number: str):
    print(f"Updating pubspec.yaml with version {version_number}")
    if os.path.exists(PUBSPEC_YAML):
        with open(PUBSPEC_YAML, "r") as f:
            content = f.read()

        new_content = re.sub(
            r"^version:.*", f"version: {version_number}", content, flags=re.MULTILINE
        )

        with open(PUBSPEC_YAML, "w") as f:
            f.write(new_content)
        print("Updated pubspec.yaml")
    else:
        print(f"Could not find {PUBSPEC_YAML}")


def update_setup_script(version_number: str):
    print(f"Updating setup script with version {version_number}")
    if os.path.exists(SETUP_SCRIPT):
        with open(SETUP_SCRIPT, "r") as f:
            content = f.read()

        # Replace the version definition line
        new_content = re.sub(
            r'^#define MyAppVersion ".*"',
            f'#define MyAppVersion "{version_number}"',
            content,
            flags=re.MULTILINE,
        )

        with open(SETUP_SCRIPT, "w") as f:
            f.write(new_content)
        print("Updated setup_script.iss")
    else:
        print(f"Could not find {SETUP_SCRIPT}")


# Bump the last number by one if its less then 10
# otherwise bump the second last number by one and set the last number to 0
# And so for the rest of the numbers
def bump_version(version_parts: list[str]):
    for i in reversed(range(len(version_parts))):
        part = int(version_parts[i])
        if i == 0 or part < 9:
            version_parts[i] = str(part + 1)
            return version_parts
        else:
            version_parts[i] = "0"
    return version_parts


def validate_version(version_number: str):
    version_parts = version_number.split(".")
    if len(version_parts) != 3:
        return False
    for part in version_parts:
        if not part.isdigit():
            return False
    return True


if __name__ == "__main__":
    version_number = input("Enter version number(press enter to auto bump): ")
    if version_number:
        while not validate_version(version_number):
            print("Invalid version number format. Example: 0.0.1")
            version_number = input("Enter version number(press enter to auto bump): ")
        update_version(manual_version_number=version_number)
    else:
        update_version()
