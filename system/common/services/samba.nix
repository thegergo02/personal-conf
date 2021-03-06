{ config, 
  pkgs, 
  inputs,
  ... 
}:

{
  imports = [ ../groups/smb.nix ] ++ [ "${inputs.secrets}/services/smb/smb.nix" ];

  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [ 5357 445 139 ];
    allowedUDPPorts = [ 3702 137 138 ];
  };
  systemd.services.add-samba-users = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    description = "Add SMB users.";
    path = [ pkgs.samba ];
    # TODO: dynamic user creation...
    script = ''
      pushd /data/homes
        (cat ${config.age.secrets.services-smb-thegergo02.path}; cat ${config.age.secrets.services-smb-thegergo02.path}) | smbpasswd -s -a thegergo02
        mkdir -p thegergo02

        (cat ${config.age.secrets.services-smb-varitomi12.path}; cat ${config.age.secrets.services-smb-varitomi12.path}) | smbpasswd -s -a varitomi12
        mkdir -p varitomi12

        chown -R root:smb /data/homes
        chmod -R g+rw /data/homes
      popd
    '';
  };
  services = {
    samba-wsdd.enable = true; # NOTE: win10 compatability
    samba = {
      enable = true;
      openFirewall = true;
      securityType = "user";
      # NOTE: netbios name can only be 15 chars, be careful
      extraConfig = ''
        workgroup = personal-conf
        server role = standalone server
        server string = ${config.networking.hostName}-samba
        netbios name = ${config.networking.hostName}
        max protocol = smb3
        hosts allow = 192.168.1. 127.0.0.1 localhost
        hosts deny = 0.0.0.0/0
        guest account = nobody
        map to guest = bad user
        force group = smb
      '';
      shares = {
        share = {
          path = "/data/share";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
        important = {
          path = "/data/important";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
        homes = {
          path = "/data/homes/%S";
          browseable = "no";
          "read only" = "no";
          "guest ok" = "no";
          "valid users" = "%S";
        };
      };
    };
  };
}
