{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  outputs = inputs: import ./outputs {inherit (inputs.fuyuNoKosei) inputs;};

  inputs.fuyuNoKosei.url = "github:TahlonBrahic/fuyu-no-kosei";
}
