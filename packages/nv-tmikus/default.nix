{ lib, stdenv }:

stdenv.mkDerivation {
  pname = "nv-tmikus";
  version = "1.0";

  src = ./src;

  installPhase = ''
    mkdir $out
    cp -r * "$out/"
  '';

  meta = with lib; {
    description = "NvChad";
    homepage = "https://github.com/NvChad/NvChad";
    platforms = platforms.all;
    maintainers = [ maintainers.tmikus ];
    license = licenses.gpl3;
  };
}
