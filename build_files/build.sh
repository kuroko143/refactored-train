#!/bin/bash

set -ouex pipefail

cp -avf "/ctx/system_files"/. /

dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sed -i "s/enabled=.*/enabled=0/g" /etc/yum.repos.d/docker-ce.repo

tee /etc/yum.repos.d/vscode.repo <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
sed -i "s/enabled=.*/enabled=0/g" /etc/yum.repos.d/vscode.repo

dnf5 -y copr enable atim/starship
dnf5 -y copr enable avengemedia/danklinux
dnf5 -y copr enable ulysg/xwayland-satellite

dnf5 -y install --enablerepo=docker-ce-stable,code \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    docker-model-plugin \
    code \
    fastfetch \
    p7zip \
    p7zip-plugins \
    stow \
    unzip \
    zip \
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
    xwayland-satellite \
    ark \
    dolphin \
    file-roller \
    gnome-calculator \
    gwenview \
    kio-extras \
    mpv \
    openssh-server \
    playerctl

dnf5 -y copr disable atim/starship
dnf5 -y copr disable avengemedia/danklinux
dnf5 -y copr disable ulysg/xwayland-satellite

systemctl enable docker.service docker.socket podman.socket

systemctl disable gdm.service
systemctl mask gdm.service
systemctl enable greetd.service
