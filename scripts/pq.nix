# scripts/pq.nix
{pkgs}:
pkgs.writeShellApplication {
  name = "pq";

  runtimeInputs = [
    pkgs.coreutils
    pkgs.findutils
    pkgs.mpv
  ];

  text = ''
    while true; do
      AUDIO_FILE=$(find "$HOME/quran/" -type f \( -name "*.mp3" -o -name "*.m4a" \) 2>/dev/null | shuf -n 1)

      if [ -n "$AUDIO_FILE" ]; then
        clear
        echo "Now Playing: $AUDIO_FILE"
        echo "Press Ctrl+C to stop."

        mpv --no-video --term-osd-bar "$AUDIO_FILE"
      else
        echo "No audio files found in $HOME/quran/!"
        break
      fi
    done
  '';
}
