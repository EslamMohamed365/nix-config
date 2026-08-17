# scripts/download-quran.nix
{pkgs}:
pkgs.writeShellApplication {
  name = "quranDownloader";

  runtimeInputs = [
    pkgs.gnused
    pkgs.coreutils
    pkgs.wget
  ];

  text = ''
    url="''${1:-}"
    sheikh_name="''${2:-}"

    # Validate arguments and URL
    if [ "$#" -ne 2 ] || [[ "$url" != *mp3quran* ]]; then
      echo "Usage: $0 <mp3quran-url> <sheikh-name>"
      echo "Example: $0 'https://server8.mp3quran.net/afs/001.mp3' 'Mishary Alafasy'"
      exit 1
    fi

    base_url=$(echo "$url" | sed 's/\/[^\/]*$//')

    # Create the destination folder and enter it
    dest="$HOME/Downloads/$sheikh_name"
    mkdir -p "$dest"
    cd "$dest" || exit 1

    echo "Downloading Quran recitation by: $sheikh_name"
    echo "Destination: $dest"

    # Download all 114 surahs
    for ((i=1; i<=114; i++)); do
      num=$(printf "%03d" "$i")
      file="''${num}.mp3"
      file_url="''${base_url}/''${file}"

      # Skip if the file already exists locally and is non-empty
      if [ -s "$file" ]; then
        echo "Skipping $file - already downloaded."
      else
        # Check if the file exists on the server
        if wget --spider -q "$file_url" 2>/dev/null; then
          echo "Downloading $file..."
          wget -c -q --show-progress "$file_url"
        else
          echo "Warning: Surah $num is not available (404 Not Found)."
        fi
      fi
    done

    echo "Done."
  '';
}
