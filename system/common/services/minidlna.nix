{ config, pkgs, ...  }:

{
  networking.firewall = {
    allowedTCPPorts = [ 5001 1900 ];
    allowedUDPPorts = [ 5001 1900 ];
  };
  services.minidlna = {
    enable = true;
    mediaDirs = [
      "V,/data/share/media/movies"
      "V,/data/share/media/shows"
      "V,/data/share/media/anime"
    ];
    friendlyName = "zeus";
    rootContainer = "B";
    extraConfig = ''
      port=5001
      inotify=yes
    '';
  };
  boot.kernel.sysctl = {
        "fs.inotify.max_user_watches" = "1048576";
  };
}
