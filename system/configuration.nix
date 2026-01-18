{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    #networking.networkmanager.enable = true;
    networking.networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };
    # Set your time zone.
    time.timeZone = "Europe/Moscow";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
    # END common
    # begin specific
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs; [ gnome-console ];

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;
    #end specific

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # $ nix search wget
    environment.systemPackages = with pkgs; [
      vim
      git
      htop
      lshw
      vulkan-tools
    ];
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # make capsLock as ctrl
    services.xserver.xkbOptions = "ctrl:nocaps";
    console.useXkbConfig = true; # apply xkb config to console (TTY)
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
