# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko
    ./services
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];

  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };
  services.logind.extraConfig = ''
    HandleLidSwitchExternalPower=ignore
    LidSwitchIgnoreInhibited=no
  '';
  # Configure console keymap
  console.keyMap = "pl2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixtpad = {
    isNormalUser = true;
    description = "Mateusz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };
  users.users.immich.extraGroups = [ "video" "render" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    stow
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "nixtpad";
  };
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    accelerationDevices = null;
  };

  services.invidious = {
    enable = true;
    port = 8090;
    sig-helper.enable = true;
  };
  services.stirling-pdf.enable = true;
  services.monero = { enable = true; };
  services.homepage-dashboard = {
    enable = true;
    listenPort = 8028;
    openFirewall = true;
    allowedHosts = "*";
    services = [
      {
        "My First Group" = [{
          "My First Immich" = {
            description = "Homepage is awesome";
            href = "http://192.168.1.12:2283";
          };
        }];
      }
      {
        "My Second Group" = [
          {
            "My Second Jellyfin" = {
              description = "Homepage is the best";
              href = "http://192.168.1.12:8096";
            };
          }
          {
            "My Second Invidous" = {
              description = "Homepage is the best";
              href = "http://192.168.1.12:8090";
            };
          }
        ];
      }
    ];
  };
  environment.etc."paperless-admin-pass".text = "admin";
  services.paperless = {
    enable = true;
    passwordFile = "/etc/paperless-admin-pass";
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ config.services.invidious.port ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

