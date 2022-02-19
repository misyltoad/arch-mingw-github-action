FROM archlinux:base-devel

LABEL maintainer="joshua@froggi.es"

RUN echo -e '\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\n\n' >> /etc/pacman.conf
RUN pacman-key --init
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Syu --noconfirm clang meson glslang git mingw-w64 wine base base-devel sed git tar curl wget bash gzip sudo file gawk grep bzip2 which pacman systemd findutils diffutils coreutils procps-ng util-linux xcb-util xcb-util-keysyms xcb-util-wm lib32-xcb-util lib32-xcb-util-keysyms

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
