{ stdenv, lib, fetchurl, makeWrapper, jdk11, glib, gtk3 }:

stdenv.mkDerivation rec {
  pname = "Tachidesk-Server";
  version = "0.7.0"; 

  src = fetchurl {
    url = "https://github.com/Suwayomi/Tachidesk-Server/releases/download/v${version}/Tachidesk-Server-v${version}-r1197.jar";
    sha256 = "4DO1WiBCu/8ypFgJdBmEwQXQ1xaWAlbt8N5TELomVVA="; 
  };

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ jdk11 glib gtk3 ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/Tachidesk-Server
    mkdir -p $out/share/applications

    cp $src $out/share/Tachidesk-Server/Tachidesk.jar

    makeWrapper ${jdk11}/bin/java $out/bin/Tachidesk-Server \
      --add-flags "-jar $out/share/Tachidesk-Server/Tachidesk.jar" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ glib gtk3 ]}" \
      --set JAVA_HOME ${jdk11}

    cat > $out/share/applications/Tachidesk-Server.desktop <<EOF
    [Desktop Entry]
    Name=Tachidesk-Server
    Comment=Start Tachidesk Server
    Exec=$out/bin/Tachidesk-Server
    Icon=https://github.com/jaminW55/japanese-packages/blob/main/tachidesk_logo.jpeg # $out/nix/???
    Terminal=true
    Type=Application
    Categories=Utility;
    EOF
  '';

  meta = with lib; {
    description = "A server to read manga";
    homepage = "https://github.com/Suwayomi/Tachidesk-Server";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
