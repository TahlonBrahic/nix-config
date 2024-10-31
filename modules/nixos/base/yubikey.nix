{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pam_u2f
    yubikey-manager
    yubioath-flutter
  ];

  services = {
    pcscd.enable = true;
    yubikey-agent.enable = true;
    udev = {
      packages = with pkgs; [yubikey-personalization];
    };
  };

  security.pam = lib.optionalAttrs pkgs.stdenv.isLinux {
    sshAgentAuth.enable = true;
    u2f = {
      enable = true;
      settings = {
        cue = false;
        authFile = "/etc/secure/Yubico/u2f_keys";
      };
    };
    services = {
      login.u2fAuth = true;
      sudo = {
        u2fAuth = true;
        sshAgentAuth = true;
      };
    };
  };
}
