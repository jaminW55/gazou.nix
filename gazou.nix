# gazou.nix
{ stdenv, fetchFromGitHub, cmake, pkg-config , lib , tesseract , leptonica , qt5 }:

stdenv.mkDerivation rec {
  pname = "gazou";
  version = "0.001-2023-08-16";

  src = fetchFromGitHub {
    owner = "kamui-fin";
    repo = "gazou";
    rev = "2114963698c94ec7e8f9023f8b6dbfa8437337de"; # Commit Hash
    sha256 = "sha256-CiIQNwL+vrCLgmOdPt6OaS0dJfw46lhM9u4hUSlTW5I="; # Let it error out to provide correct sha256
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake pkg-config qt5.wrapQtAppsHook ];
  buildInputs = [ tesseract leptonica qt5.qtbase qt5.qtx11extras ];

  cmakeArgs = [
    "-DGUI=ON"
  ];

  meta = {
    description = "A OCR for Japanese and Chinese Characters";
    license = lib.licenses.gpl3Only;
    maintainers = with stdenv.lib.maintainers; [ jaminW55 ];
  };
}
