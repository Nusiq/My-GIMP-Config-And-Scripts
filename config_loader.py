from pathlib import Path
import json
import os
import argparse
import shutil

SCRIPT_CONFIG_FILE_PATH  = Path('config_loader_config.json')
GIMP_CONFIG_FILE_NAMES = [
    # "gimprc", Not used because verrides file paths (which is user specific)
    "menurc",
    "toolrc",
]



def load_gimp_config_path_from_config() -> Path | None:
    '''
    Loads the path to the GIMP configuration directory from the
    config_loader_config.json file.
    '''
    if not SCRIPT_CONFIG_FILE_PATH.exists():
        return None
    try:
        with SCRIPT_CONFIG_FILE_PATH.open('r') as f:
            config = json.load(f)
            return Path(config['gimp_config_path'])
    except:
        return None

def find_gimp_config_path_interactive() -> Path | None:
    '''
    Finds the path to the GIMP configuration directory.
    '''
    appdata = os.getenv('APPDATA')
    if appdata is not None:
        gimp_paths = list((Path(appdata) / 'GIMP').glob("*"))
        if len(gimp_paths) == 1:
            return gimp_paths[0]
    return None

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--import", dest="import_flag", action="store_true", default=False,
        help=(
            "Import the files from the GIMP configuration directory to this "
            "repository."))
    parser.add_argument(
        "--export", action="store_true", default=False, help=(
            "Export the files from this repository to the GIMP configuration "
            "directory."))
    args = parser.parse_args()

    if args.import_flag == args.export:
        print(
            "The script must be called with either --import or --export flag "
            "(but not both). Use --help for more information.")
        return
    # Get the gimp path
    print(
        "Trying to load the GIMP path from the configuration file: "
        f"{SCRIPT_CONFIG_FILE_PATH.as_posix()}")
    gimp_path = load_gimp_config_path_from_config()
    if gimp_path is None:
        print(
            "Unable to load the GIMP path form the script's configuration "
            "file. Trying to find the path in the file system...\n")
        gimp_path = find_gimp_config_path_interactive()
        if gimp_path is not None:
            print(f"Found the GIMP path: {gimp_path.as_posix()}")
            answer = input("Is this path correct? [y/n]: ")
            if answer.lower() != 'y':
                gimp_path = None
        if gimp_path is None:
            print(
                "Unable to find the GIMP path in the file system. "
                "Please enter the path to the GIMP configuration directory.")
            answer = input("Enter the path and press ENTER: ")
            if answer == "":
                print("The path cannot be empty.")
                return
            gimp_path = Path(answer)

    # Check if the path exists
    if not gimp_path.exists():
        print(f"The specified path does not exist.\nPath: {gimp_path}")
        return
    # Save the path to the configuration file
    with SCRIPT_CONFIG_FILE_PATH.open('w') as f:
        json.dump({'gimp_config_path': gimp_path.as_posix()}, f)

    source: Path
    destination: Path
    for file in GIMP_CONFIG_FILE_NAMES:
        if args.import_flag:
            source = gimp_path / file
            destination = Path("user_config") / file
        elif args.export:
            source = Path("user_config") / file
            destination = gimp_path / file
        else:
            raise ValueError("Invalid state.")
        if source.exists():
            print(f"Copying {source} to {destination}")
            if destination.exists():
                destination.unlink()
            destination.write_text(source.read_text())
            shutil.copy(source, destination)
        else:
            print(f"File {source} does not exist.")


if __name__ == '__main__':
    main()