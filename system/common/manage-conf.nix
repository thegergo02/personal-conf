{ config, pkgs, ...  }:

{
  imports = [ groups/conf.nix ];
  systemd.services.manage-conf = {
    script = ''
      cd /etc/
      rm -rf nixos
      git clone https://git.freeself.one/thegergo02/personal-conf
      mv personal-conf nixos
      cd /etc/nixos
      mv /etc/hardware-configuration.nix ./system/$HOST/.
      # TODO: git push
      # TODO: apply somewhere (but installer does not need it for example)
      chown -R root:conf /etc/nixos
      chmod -R g+w /etc/nixos
    '';
    description = "Get the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    /*serviceConfig.Restart = "on-failure";
    serviceConfig.RestartSec = 5;
    serviceConfig.StartLimitIntervalSec = 500;
    serviceConfig.StartLimitBurst = 5;*/
    serviceConfig.Type = "oneshot";
    path = [ pkgs.git ];
  };
}
