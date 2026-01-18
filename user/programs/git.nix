{
  config,
  pkgs,
  unstable-pkgs,
  ...
}:
{
  home.packages = [
    pkgs.git
  ];
  # TODO: set up signed commits
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = config.userSettings.email;
        name = config.userSettings.name;
      };
      init.defaultBranch = "main";
    };
  };
}
