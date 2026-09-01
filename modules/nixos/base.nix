# Shared configuration for all hosts.
{
  config,
  pkgs,
  ...
}: {
  time.timeZone = "Africa/Cairo";
  environment.systemPackages = with pkgs; [
    ntfs3g
    wget
    deadnix
    unrar
  ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    FLAKE = "${config.users.users.eslam.home}/nix-config";
  };
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };
  programs = {
    zsh.enable = true;
    ssh = {
      startAgent = true;
    };
  };
  services.auto-cpufreq.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.05";
}
