{ config, pkgs, ... }:

{
  services.invidious = {
    enable = true;
    port = 8090;
    sig-helper.enable = true;
  };
}
