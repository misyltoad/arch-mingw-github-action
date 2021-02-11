# Need to use an older version of Arch because of Pacman breakage...
FROM archlinux:base-devel-20210124.0.14185

LABEL maintainer="joshua@froggi.es"

RUN echo -e '\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\n\n' >> /etc/pacman.conf
RUN pacman -Syu --noconfirm meson glslang git mingw-w64 wine base base-devel sed git tar curl wget bash gzip sudo file gawk grep bzip2 which pacman systemd findutils diffutils coreutils procps-ng util-linux

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]