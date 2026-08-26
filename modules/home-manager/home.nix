# This is your home-manager configuration file
# Used via the NixOS-integrated module (home-manager.users.eslam)
{
  config,
  pkgs,
  ...
}: let
  quranDownloader = pkgs.callPackage ../../scripts/quranDownloader.nix {};
  pq = pkgs.callPackage ../../scripts/pq.nix {};
  sn = pkgs.callPackage ../../scripts/ns.nix {};
in {
  home = {
    username = "eslam";
    homeDirectory = "/home/eslam";
    shell.enableZshIntegration = true;
    packages = with pkgs; [
      sn
      pq
      qbittorrent
      video-downloader
      quranDownloader
      ripgrep
      fetch
      git-extras
      fd
      wl-clipboard
      pavucontrol
      skills
      playerctl
      brightnessctl
    ];
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "26.05";
  };
  stylix = {
    targets.firefox.profileNames = ["eslam"];
  };
  imports = [
    ./firefox.nix
    ./hyprland.nix
    ./nvf.nix
    ./yazi.nix
    ./zsh.nix
    ./tmux.nix
  ];
  programs = {
    devenv.enable = true;
    starship.enable = true;
    satty.enable = true;
    kitty.enable = true;
    mpv.enable = true;
    lazygit.enable = true;
    fzf.enable = true;
    gh.enable = true;
    tealdeer.enable = true;
    opencode.enable = true;
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
    eza = {
      enable = true;
      icons = "auto";
      git = true;
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
      flake = "${config.home.homeDirectory}/nix-config"; # sets NH_OS_FLAKE variable for you
    };
  };
  services = {
    mako.enable = true;
    cliphist.enable = true;
  };
}
