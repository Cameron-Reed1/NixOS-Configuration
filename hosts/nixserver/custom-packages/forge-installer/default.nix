{
  lib,
  stdenvNoCC,
  fetchurl,
  jre,
  makeBinaryWrapper,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "forge-installer";
  version = "1.18.2-40.2.9";

  src =
    fetchurl {
      url = "https://maven.minecraftforge.net/net/minecraftforge/forge/${finalAttrs.version}/forge-${finalAttrs.version}-installer.jar";
      hash = "sha256-N/GpCeXZUH3//IIhUgCTCoI+nCcttlQghIXO7sk3rFk=";
    };

  installPhase = ''
    runHook preInstall

    install -D $src $out/bin/installer.jar

    echo "#!/usr/bin/env bash

if [[ ! -d libraries ]]; then
  ${lib.getExe jre} -jar $out/bin/installer.jar --installServer
  sed -e \"s|libraries|\$(pwd)/libraries|g\" libraries/net/minecraftforge/forge/${finalAttrs.version}/unix_args.txt > forge_args.txt
  rm run.sh run.bat user_jvm_args.txt installer.jar.log
fi

exec $out/bin/run \$@" > $out/bin/minecraft-server
    chmod +x $out/bin/minecraft-server

    makeWrapper ${lib.getExe jre} "$out/bin/run" \
      --append-flags "@forge_args.txt nogui"

    runHook postInstall
  '';

  nativeBuildInputs = [
    jre
    makeBinaryWrapper
  ];

  buildInputs = [
    jre
  ];

  dontUnpack = true;
  preferLocalBuild = true;
  allowSubstitutes = false;

  meta = {
    description = "Annoying Minecraft Server";
    homepage = "https://minecraftforge.net/";
    platforms = lib.platforms.unix;
    mainProgram = "minecraft-server";
  };
})
