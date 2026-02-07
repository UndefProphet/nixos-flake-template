# User

{ user, stateVersion, ... }: {

  # User
  users = {
    users."${user}" = {
      isNormalUser = true;
      description = "${user}";
      extraGroups =
        [ "wheel" ];
    };
  };

  # Home Manager 
  home-manager.users.${user} = {
    home = {
      inherit stateVersion;
      username = "${user}";
      homeDirectory = "/home/${user}";
    };
  };
}
