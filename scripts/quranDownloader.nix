# scripts/download-quran.nix
{pkgs}:
pkgs.writeShellScriptBin "quranDownloader" ''
  url="''$1"

  if [ ''$# -ne 1 ] || [[ "''$url" != *mp3quran* ]]; then
    echo "Usage: ''$0 <mp3quran-url>"
    echo "Example: ''$0 'https://server8.mp3quran.net/afs/001.mp3'"
    exit 1
  fi

  sheikh_name=$(echo "''$url" | ${pkgs.gawk}/bin/awk -F'/' '{print $(NF-1)}')
  base_url=$(echo "''$url" | ${pkgs.gnused}/bin/sed 's/\/[^\/]*$//')

  # Create folder & enter it
  dest="$HOME/Downloads/''$sheikh_name"
  ${pkgs.coreutils}/bin/mkdir -p "''$dest"
  cd "''$dest" || exit 1

  # Download 114 surahs with check using wget
  for i in {1..114}; do
    num=$(${pkgs.coreutils}/bin/printf "%03d" "''$i")
    file="''${num}.mp3"
    file_url="''${base_url}/''${file}"

    # Check if file exists locally and is not empty
    if [ -s "''$file" ]; then
      echo "Skipping ''$file - already downloaded."
    else
      # Check if file exists on the server (returns 200 OK)
      if ${pkgs.wget}/bin/wget --spider -q "''$file_url"; then
        echo "Downloading ''$file..."
        ${pkgs.wget}/bin/wget -c -q --show-progress "''$file_url"
      else
        echo "⚠️  Surah ''$num is not available for this sheikh (404 Not Found)."
      fi
    fi
  done
''
