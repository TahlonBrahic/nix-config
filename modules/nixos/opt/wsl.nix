{vars, ...}: {
  wsl = {
    enable = true;
    defaultUser = vars.username;
    startMenuLaunchers = true;

    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = false;
      network.generateHosts = false;
    };
  };
  environment.etc."resolv.conf".source = /etc/resolv.conf;
}
