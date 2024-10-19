{
  stdenv,
  lib,
  fetchFromGithub,
  kernel,
  kmod
}:

stdenv.mkDerivation rec {
  pname = "samsung-volatile";
  version = "1.0";

  src = fetchFromGithub {
    owner = "tbrahic";
    repo = "linux";
    rev = "v${version}";
    hash = "";
  };

  sourceRoot = "linux/drivers/platform/x86/samsung-laptop.c";
  hardeningDisable = ["pic"];
  nativeBuildInputs = kernel.ModuleBuildDependencies;

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)}"
  ];

  meta = {
    description = "A modified samsung-laptop kernel module that can boot from EFI systems";
    homepage = "https://github.com/tahlonbrahic/linux";
    license = lib.licenses.gpl2;
    maintainers = with lib.maintainers; [ tahlonbrahic ];
    platforms = lib.platforms.linux;
  };
}
