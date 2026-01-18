{ pkgs, unstable-pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      ffmpeg
    ];
  };
}
