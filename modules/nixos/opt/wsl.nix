{
  inputs,
  hostName,
  ...
}: {
  # NOTE: the home-manager module still needs to be imported manually in outputs/${system}src/${hostname}
  imports = [inputs.nixos-wsl.nixosModules.wsl];

  wsl = {
    enable = true;
    defaultUser = "tbrahic";
    startMenuLaunchers = true;

    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = false;
      network.generateHosts = false;
      network.hostname = "${hostName}";
    };
  };

  # Enable auto-generated name servers
  environment.etc."resolv.conf".source = /etc/resolv.conf;
}
