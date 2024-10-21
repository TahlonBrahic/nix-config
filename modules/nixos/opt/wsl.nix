{
  inputs, 
  vars, 
  ...
}: 
{  
  # NOTE: the home-manager module still needs to be imported manually in outputs/${system}src/${hostname}
  imports = [inputs.nixos-wsl.nixosModules.wsl];

  wsl = {
    enable = true;
    defaultUser = vars.username;
    startMenuLaunchers = true;
    
    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = false;
      network.generateHosts = false;
      network.hostname = "${vars.hostName}";
    };
  };

  # Enable auto-generated name servers
  environment.etc."resolv.conf".source = /etc/resolv.conf;
}
