{ config, lib, ... }:

{
  options = {
    systemSettings = {
      adminUsers = lib.mkOption {
        description = "List of users to grant admin (sudo) access on the system";
        type = lib.types.listOf lib.types.str;
      };
      usersInfo = lib.mkOption {
        description = "List of structures that describe unique user";
        type = lib.types.listOf lib.types.attrs;
      };
    };
  };
  config = {
    users.users = builtins.listToAttrs (
      map (userInfo: {
        name = userInfo.user;
        value = {
          isNormalUser = true;
          # TODO: description?!
          extraGroups = [
            "networkmanager"
          ]
          ++ (lib.optionals (lib.any (x: x == userInfo.user) config.systemSettings.adminUsers) [ "wheel" ]);
          createHome = true;
        };
      }) config.systemSettings.usersInfo
    );

    home-manager.users = builtins.listToAttrs (
      map (userInfo: {
        name = userInfo.user;
        value = {
          home.username = userInfo.user;
          home.homeDirectory = "/home/" + userInfo.user;
        };
      }) config.systemSettings.usersInfo
    );
  };
}
