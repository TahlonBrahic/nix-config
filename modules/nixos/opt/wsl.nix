{vars, ...}: {
  wsl = {
    enable = true;
    defualtUser = vars.username;
    startMenuLaunchers = true;

    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = false;
      network.generateHosts = false;
    };
  };
}
