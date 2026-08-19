{
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    extraPackages = with pkgs; [
      ffmpegthumbnailer # video thumbnails
      _7zz # archive preview/extract (7-Zip)
      zip # compress plugin default format
      poppler-utils # pdf preview
      udisks2 # mount plugin backend (udisksctl)
      chafa # image preview fallback
    ];
    settings.manager = {
      sort_by = "natural";
      show_hidden = false;
    };
    plugins = {
      smart-enter = {
        package = pkgs.yaziPlugins.smart-enter;
        setup = true;
        settings.open_multi = false;
      };
      mount = {
        package = pkgs.yaziPlugins.mount;
      };
      chmod = {
        package = pkgs.yaziPlugins.chmod;
      };
      compress = {
        package = pkgs.yaziPlugins.compress;
      };
    };
    keymap.mgr.prepend_keymap = [
      {
        on = "l";
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
      {
        on = "M";
        run = "plugin mount";
        desc = "Mount manager";
      }
      {
        on = [
          "c"
          "m"
        ];
        run = "plugin chmod";
        desc = "Chmod on selected files";
      }
      {
        on = [
          "c"
          "a"
        ];
        run = "plugin compress";
        desc = "Archive selected files";
      }
    ];
  };
}