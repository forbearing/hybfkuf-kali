# ref:
#   https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-debian-10
#   https://www.kali.org/docs/general-use/novnc-kali-in-browser/

FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

#COPY repos/sources.list-ustc /etc/apt/sources.list
#COPY repos/sources.list-aliyun /etc/apt/sources.list

#COPY repos/docker-ce.list-default /etc/apt/sources.list.d/docker-ce.list
#COPY repos/docker-ce.list-ustc /etc/apt/sources.list.d/docker-ce.list
#COPY repos/docker-ce.list-aliyun /etc/apt/sources.list.d/docker-ce.list

#curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg | gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/debian/gpg | gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

COPY repos/sources.list-aliyun  /etc/apt/sources.list
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        passwd coreutils apt-file apt-transport-https software-properties-common iputils-ping bash-completion man \
        psmisc procps dnsutils lvm2 ntp ntpdate sysstat tree lsof netcat-openbsd mtr iperf apache2-utils \
        wget curl zip unzip bzip2 vim net-tools git zsh fish rsync jq gpg \
        pciutils iputils-ping bash-completion vim && \
    apt-get install -y \
        kali-tools-top10 \
        kali-desktop-xfce xfce4 xfce4-goodies \
        firefox-esr firefox-esr-l10n-zh-cn \
        ssh novnc x11vnc xvfb xorg xrdp tightvncserver \
        fcitx-googlepinyin && \
    apt-get autoclean -y && \
    apt-get autoremove -y

COPY repos/docker-ce.list-default repos/docker-ce-archive-keyring.gpg /
RUN mv /docker-ce.list-default /etc/apt/sources.list.d/docker-ce.list && \
    mv /docker-ce-archive-keyring.gpg /usr/share/keyrings/docker-ce-archive-keyring.gpg && \
    apt-get update && \
    apt-get install -y \
        docker-ce-cli

RUN mv /root /root.bak

COPY docker-entrypoint.sh clean /
ENTRYPOINT ["/docker-entrypoint.sh"]

# noVNC
#   apt-get clean -y novnc x11vnc xvfb
#   x11vnc -display :0 -autoport -localhost -nopw -bg -xkb -ncache -ncache_cr -quiet -forever
#   x11vnc -forever -usepw -create &
#   x11vnc -nopw -bg -xkb -ncache -ncache_cr -quiet -forever
#   x11vnc -nopw -bg -xkb -ncache -ncache_cr -quiet -forever -create
