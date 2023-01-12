FROM archlinux:base-devel

LABEL maintainer="joshua@froggi.es"

RUN echo -e '\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\n\n' >> /etc/pacman.conf
RUN pacman-key --init
RUN pacman -Sy --needed --noconfirm archlinux-keyring
RUN pacman -Syu --needed --noconfirm clang meson glslang git mingw-w64 wine base bash base-devel sed git tar curl wget bash gzip sudo file gawk grep bzip2 which pacman systemd findutils diffutils coreutils procps-ng util-linux xcb-util xcb-util-keysyms xcb-util-wm lib32-xcb-util lib32-xcb-util-keysyms glfw-x11
RUN git config --system --add safe.directory /github/workspace

# create a builduser, as we cant run makepkg as root
RUN useradd builduser -m
# delete the password of the build user
RUN passwd -d builduser
# allow the builduser to use sudo without a password
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers 

# clone, build, then install the lib32-glfw-x11 AUR package (there is no lib32 glfw in the standard Arch repositories)
RUN sudo -u builduser bash -c 'export OLD_PWD=$PWD && cd ~ && git clone https://aur.archlinux.org/lib32-glfw.git lib32-glfw-x11 && cd lib32-glfw-x11 && makepkg -s --noconfirm && sudo pacman --noconfirm -U lib32-glfw-x11* && cd $OLD_PWD'

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
