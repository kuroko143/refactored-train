#!/bin/bash

set -ouex pipefail

cp -avf "/ctx/system_files"/. /

SCRIPT_DIR="/ctx/scripts"
"$SCRIPT_DIR/01-docker.sh"
"$SCRIPT_DIR/02-nix.sh"
"$SCRIPT_DIR/03-vscode.sh"

dnf5 -y copr enable avengemedia/dms
dnf5 -y copr enable avengemedia/danklinux
dnf5 -y copr enable atim/starship

dnf5 -y install --enablerepo=docker-ce-stable,code \
containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    docker-model-plugin \
    busybox \
    nix \
    nix-daemon \
    nix-legacy \
    code \
    atuin \
    eza \
    kitty \
    neovim \
    starship \
    blueman \
    dms \
    dms-greeter \
    fuzzel \
    greetd \
    greetd-selinux \
    kvantum \
    niri \
    pavucontrol \
    qt6-qtmultimedia \
    qt6ct \
    xdg-desktop-portal \
    xdg-desktop-portal-gnome \
    xdg-desktop-portal-gtk \
    https://kojipkgs.fedoraproject.org//packages/xwayland-satellite/0.8.1/1.fc44/x86_64/xwayland-satellite-0.8.1-1.fc44.x86_64.rpm \
    fastfetch \
    p7zip \
    p7zip-plugins \
    stow \
    unzip \
    zip \
    ark \
    dolphin \
    file-roller \
    gnome-calculator \
    gwenview \
    kio-extras \
    mpv \
    openssh-server \
    playerctl

dnf5 -y copr disable avengemedia/dms
dnf5 -y copr disable avengemedia/danklinux
dnf5 -y copr disable atim/starship

systemctl enable docker.service docker.socket podman.socket
systemctl enable nix.mount nix-daemon

systemctl disable gdm.service
systemctl mask gdm.service
systemctl enable greetd.service
