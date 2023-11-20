# gazou_wayland.nix
{ stdenv, fetchFromGitHub, cmake, pkg-config , lib , tesseract , leptonica , qt5 }:

stdenv.mkDerivation rec {
  pname = "gazou_wayland";
  version = "0.001-2023-11-20";

  src = fetchFromGitHub {
    owner = "metcalsr28";
    repo = "gazou_wayland";
    rev = "d2d40f645d7190bbeb42f686a674e4840b38d8ed";
    sha256 = "sha256-hxOMsCbBP+tl/qxteLIATPmzNp7ZGZslyOdCtHmIqLg=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake pkg-config qt5.wrapQtAppsHook ];
  buildInputs = [ tesseract leptonica qt5.qtbase qt5.qtx11extras ];

  cmakeArgs = [
    "-DGUI=OFF"
  ];

  meta = {
    description = "A OCR for Japanese and Chinese Characters";
    license = lib.licenses.gpl3Only;
    maintainers = with stdenv.lib.maintainers; [ jaminW55 ];
  };
}
