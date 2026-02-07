{ config, configName, stateVersion, pkgs, user, location, inputs, ... }: {

  # Modules
  imports = [
    # Home Manager
    inputs.home-manager.nixosModules.home-manager

    # Components
    ./user.nix
  ];

  # Home Manager Config
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  # Home Manager enable for user
  home-manager.users.${user}.programs.home-manager.enable = true;

  # Set special args
  home-manager.extraSpecialArgs = {
    hm-config = config.home-manager.users.${user};
  };

  # Nix Config
  system = { inherit stateVersion; };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nh = {
    enable = true;
    # flake = "${location}#${configName}";
    flake = "${location}";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true; # Required for swapfile hibernationpep

  # Firmware update
  # services.fwupd = { enable = true; };


  environment.systemPackages = with pkgs; [

  ];

}
