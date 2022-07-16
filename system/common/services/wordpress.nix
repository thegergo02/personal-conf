{ config, pkgs, ...  }:

{
  services.wordpress.sites."varigergo.xyz".virtualHost.listen."*".port = 8500;
  services.wordpress.sites."varigergo.xyz" = {
    database = {
      host = "localhost";
      port = "5432";
      user = "wordpress";
    };
    uploadsDir = "/data/persist/wordpress/uploads";
  };
}
