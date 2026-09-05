{pkgs, ...}: {
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
      fd # faster find, used by some plugins/filters
      ripgrep # faster in-file search
      jq # json preview/formatting
    ];

    settings = {
      mgr = {
        sort_by = "natural";
        sort_dir_first = true;
        show_hidden = false;
        linemode = "size";
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };

    plugins = {
      smart-enter = {
        package = pkgs.yaziPlugins.smart-enter;
        setup = true;
        settings.open_multi = false;
      };
      mount.package = pkgs.yaziPlugins.mount;
      chmod.package = pkgs.yaziPlugins.chmod;
      compress.package = pkgs.yaziPlugins.compress;
      full-border.package = pkgs.yaziPlugins.full-border;
    };

    initLua = ''
      require("full-border"):setup()
    '';

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
        on = ["c" "m"];
        run = "plugin chmod";
        desc = "Chmod on selected files";
      }
      {
        on = ["c" "a"];
        run = "plugin compress";
        desc = "Archive selected files";
      }
      {
        on = "<C-a>";
        run = "select_all --state=true";
        desc = "Select all files";
      }
      {
        on = "<C-r>";
        run = "select_all --state=none";
        desc = "Deselect all files";
      }
    ];
  };
}
