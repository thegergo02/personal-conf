{ config, inputs, ... }:

{
  imports = [ "${inputs.secrets}/services/zitadel/zitadel.nix" ];
  config.services.zitadel = {
    enable = true;
    extraConfig = ''
      ExternalSecure: true
      ExternalDomain: sso.freeself.one
      ExternalPort: 443
      S3DefaultInstance:
        CustomDomain: sso.freeself.one
    '';
    extraCommand = "--tlsMode external --steps ${config.age.secrets.services-zitadel-admin.path} --config ${config.age.secrets.services-zitadel-admin.path} --masterkeyFile ${config.age.secrets.services-zitadel-masterkey.path}";
  };
  config.services.cockroachdb22 = {
    enable = true;
    workingDirectory = /data/postgres/cockroach;
  };
}
