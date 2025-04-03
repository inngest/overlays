{ stdenv, autoPatchelfHook, fetchurl, xz, zlib, dpkg }:

stdenv.mkDerivation (finalAttrs: {
  pname = "libfdb-client";
  version = "7.3.42";
  sha256 = "f9115d5635d0e94db6ece006adcbee4a2d5589c4d904e761f3422c67fb52fe55";

  src = fetchurl {
    url =
      "https://github.com/apple/foundationdb/releases/download/${finalAttrs.version}/foundationdb-clients_${finalAttrs.version}-1_amd64.deb";
    sha256 = "${finalAttrs.sha256}";
  };

  nativeBuildInputs = [ autoPatchelfHook xz zlib dpkg ];

  sourceRoot = ".";
  unpackCmd = ''
    dpkg -x "$src" .
  '';

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r usr/include $out/include
    cp usr/lib/libfdb_c.so $out/include/
    chmod 555 $out/include/libfdb_c.so
  '';
})
