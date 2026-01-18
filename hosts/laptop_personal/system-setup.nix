{ pkgs, ... }:

{
  config = {
    systemSettings = {
      usersInfo = [
        {
          user = "ivant";
          email = "tetyushkin.ia@outlook.com";
          name = "Ivan Tetyushkin";
        }
      ];
      adminUsers = [ "ivant" ];
    };
  };
}
