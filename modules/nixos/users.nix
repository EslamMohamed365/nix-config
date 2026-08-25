{pkgs, ...}: {
  users.users = {
    eslam = {
      #TODO: Set with `passwd` after first boot
      initialPassword = "mypasswd";
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };
}
