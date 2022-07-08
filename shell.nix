{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    automake
    autoconf
    pkgs.beam.packages.erlangR25.elixir
    erlangR25
    file
    fwup
    git
    glew
    glfw
    lxqt.lxqt-openssh-askpass
    inotify-tools
    openssh
    rebar3
    squashfsTools
    xlibsWrapper
    x11_ssh_askpass
    xorg.libXdmcp
  ];
}
