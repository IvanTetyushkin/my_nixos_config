_: {
  programs.bash = {
    enable = true;
    shellAliases = {
      gst = "git status";
      btw = "echo WORKS";
      ".." = "cd ..";
    };
  };

}
