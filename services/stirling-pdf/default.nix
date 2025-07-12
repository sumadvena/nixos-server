{ config, pkgs, ... }: {
  services.stirling-pdf = {
    enable = true;

    # Homepage metadata
    homepage = {
      name = "Stirling PDF";
      description = "PDF manipulation tool";
      port = 8080;
      icon = "stirling-pdf";
    };
  };
}
