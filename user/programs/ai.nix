{ pkgs, unstable-pkgs, ... }:
{
  home = {
    packages = with unstable-pkgs; [
      ollama-vulkan
    ];
  };
}
