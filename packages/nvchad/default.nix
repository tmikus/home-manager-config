{ lib, stdenv, pkgs }:

let
  custom = ./custom;
in
stdenv.mkDerivation {
  pname = "nvchad";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "starter";
    rev = "aad624221adc6ed4e14337b3b3f2b74136696b53";
    sha256 = "0vk5dqp3xy3fcgzjw4vrr5ishx1gbg28xcckfzz4amn8v4ynlwyq";
  };

  installPhase = ''
    mkdir $out
    cp -r * "$out/"
    mkdir -p "$out/lua/custom"
    cp -r ${custom}/* "$out/lua/custom/"
  '';

  meta = with lib; {
    description = "NvChad";
    homepage = "https://github.com/NvChad/NvChad";
    platforms = platforms.all;
    maintainers = [ maintainers.rayandrew ];
    license = licenses.gpl3;
  };
}

