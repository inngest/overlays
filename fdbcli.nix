{ stdenv, fetchurl }:

stdenv.mkDerivation (attrs: {
  pname = "fdbcli";
  version = "7.3.42";
  sha256 = "4c908829e327e08db27cc75916fba38c520577679e8f4627dab66f5672892473";

  src = fetchurl {
    url =
      "https://github.com/apple/foundationdb/releases/download/${attrs.version}/fdbcli.x86_64";
    sha256 = "${attrs.sha256}";
  };

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin;
    cp $src $out/bin/fdbcli
    chmod +x $out/bin/fdbcli
  '';
})
