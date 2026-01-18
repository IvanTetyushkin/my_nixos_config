{ config, hw_config_path, ... }:

{
  imports = [
    ./system-setup.nix

    "${hw_config_path}/hardware-configuration.nix"
  ];

  config = {
    home-manager.users = builtins.listToAttrs (
      map (userInfo: {
        name = userInfo.user;
        value = {
          imports = [
            (import ./user-setup.nix { userInfo = userInfo; })
            ../../user
          ];
        };
      }) config.systemSettings.usersInfo
    );
  };
}
