# This is your home-manager configuration file
# Used via the NixOS-integrated module (home-manager.users.eslam)
{
  config,
  pkgs,
  inputs,
  ...
}: let
  quranDownloader = pkgs.callPackage ../../scripts/quranDownloader.nix {};
  pq = pkgs.callPackage ../../scripts/pq.nix {};
  sn = pkgs.callPackage ../../scripts/ns.nix {};
in {
  home = {
    username = "eslam";
    homeDirectory = "/home/eslam";
    shell.enableNushellIntegration = true;
    packages = with pkgs; [
      worktrunk
      sn
      pq
      qbittorrent
      video-downloader
      quranDownloader
      ripgrep
      fetch
      git-extras
      fd
      persepolis
      wl-clipboard
      pavucontrol
      skills
      playerctl
      brightnessctl
      awscli2
    ];
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "26.05";
  };
  stylix = {
    targets.firefox.profileNames = ["eslam"];
  };
  imports = [
    (inputs.import-tree ./active-config)
  ];
  programs = {
    devenv.enable = true;
    jqp.enable = true;
    starship.enable = true;
    satty.enable = true;
    kitty.enable = true;
    mpv.enable = true;
    lazygit.enable = true;
    gh.enable = true;
    tealdeer.enable = true;
    opencode.enable = true;
    carapace.enable = true;
    fzf = {
      enable = true;
      defaultCommand = "fd --type f --strip-cwd-prefix --hidden --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'"
      ];
      fileWidget = {
        command = "fd --type f --strip-cwd-prefix --hidden --exclude .git";
        options = [
          "--preview 'head -n 100 {}'"
        ];
      };
      changeDirWidget = {
        command = "fd --type d --strip-cwd-prefix --hidden --exclude .git";
        options = [
          "--preview 'ls -la {}'"
        ];
      };
    };
    fuzzel = {
      enable = true;
      settings = {
        "key-bindings" = {
          delete-line-forward = "none";
          next = "Down Control+j Control+n";
          prev = "Up Control+k Control+p";
          cursor-left = "Left Control+h";
          cursor-right = "Right Control+l";
        };
      };
    };
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
        transparency = false;
        rounded_corners = true;
        terminal_sync = true;
      };
    };
    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };
    hyprshot = {
      enable = true;
      saveLocation = "$HOME/Pictures/Screenshots";
    };
    ashell = {
      enable = true;
      systemd.enable = true;
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*" = {
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
      };
    };
    git = {
      enable = true;
      settings = {
        user.name = "EslamMohamed365";
        user.email = "am5484452@gmail.com";
        init.defaultBranch = "main";
      };
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "${config.home.homeDirectory}/nix-config"; # sets NH_FLAKE variable for you
    };
  };
  xdg.configFile."worktrunk/config.toml".source = ./config/worktrunk/config.toml;
  services = {
    mako.enable = true;
    cliphist.enable = true;
  };
}
