FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive


ADD busybox.tar.xz /
COPY repos/sources.list-aliyun repos/docker-ce.list-default repos/docker-ce-archive-keyring.gpg /

RUN mv /sources.list-aliyun /etc/apt/sources.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        passwd coreutils apt-file apt-utils apt-transport-https software-properties-common iputils-ping bash-completion man \
        psmisc procps dnsutils lvm2 ntp ntpdate sysstat tree lsof netcat-openbsd mtr iperf apache2-utils binutils libc-bin \
        wget curl zip unzip bzip2 vim net-tools git zsh fish rsync jq gpg \
        pciutils iputils-ping bash-completion vim && \
    apt-get install -y \
        kali-tools-top10 \
        kali-desktop-xfce xfce4 xfce4-goodies \
        firefox-esr firefox-esr-l10n-zh-cn \
        ssh novnc x11vnc xvfb xorg xrdp tightvncserver \
        fcitx-googlepinyin && \
    mv /docker-ce.list-default /etc/apt/sources.list.d/docker-ce.list && \
    mv /docker-ce-archive-keyring.gpg /usr/share/keyrings/docker-ce-archive-keyring.gpg && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    cp -r /usr /.usr && \
    cp -r /etc /.etc && \
    mv /root /.root && \
    mv /boot /.boot && \
    mv /run /.run && \
    rm -rf /var/log/* \
    rm -rf /var/lib/apt/lists/* && \
    mv /var/ .var && \
    mkdir -p /.root/tinySystem/usr/bin && \
    mkdir -p /.root/tinySystem/usr/sbin && \
    mkdir -p /.root/tinySystem/usr/lib && \
    mkdir -p /.root/tinySystem/usr/lib64 && \
    mkdir -p /.root/tinySystem/etc && \
    cp /bin/rsync /.root/tinySystem/usr/bin/ && \
    cp /bin/ldd /.root/tinySystem/usr/bin/ && \
    mv /busybox /.root/tinySystem/usr/bin/ && \
    for item in "$(ldd /bin/rsync /bin/ldd 2> /dev/null | awk '{print $3}' | sort -u)"; do cp $item /.root/tinySystem/usr/lib/ ;done && \
    for item in "$(ldd /bin/rsync /bin/ldd 2> /dev/null | grep lib64 | awk '{print $1}' | sort -u)"; do cp $item /.root/tinySystem/usr/lib64/; done && \
    rsync -avzH -q --delete --exclude='hosts' --exclude='resolv.conf' --exclude='hostname' /.root/tinySystem/etc/ /etc/ && \
    rsync -avzH -q --delete /.root/tinySystem/usr/ /usr/ && \
    for item in $(/bin/busybox --list); do /bin/busybox ln -s /bin/busybox /bin/$item; done

COPY docker-entrypoint.sh clean /
ENTRYPOINT ["/docker-entrypoint.sh"]




















#FROM kalilinux/kali-rolling

#ENV DEBIAN_FRONTEND=noninteractive

#COPY repos/sources.list-aliyun  /etc/apt/sources.list
#RUN apt-get update && \
#    apt-get install --no-install-recommends -y \
#        passwd coreutils apt-file apt-transport-https software-properties-common iputils-ping bash-completion man \
#        psmisc procps dnsutils lvm2 ntp ntpdate sysstat tree lsof netcat-openbsd mtr iperf apache2-utils \
#        wget curl zip unzip bzip2 vim net-tools git zsh fish rsync jq gpg \
#        pciutils iputils-ping bash-completion vim && \
#    apt-get install -y \
#        kali-tools-top10 \
#        kali-desktop-xfce xfce4 xfce4-goodies \
#        firefox-esr firefox-esr-l10n-zh-cn \
#        ssh novnc x11vnc xvfb xorg xrdp tightvncserver \
#        fcitx-googlepinyin && \
#    apt-get autoclean -y && \
#    apt-get autoremove -y

#COPY repos/docker-ce.list-default repos/docker-ce-archive-keyring.gpg /
#RUN mv /docker-ce.list-default /etc/apt/sources.list.d/docker-ce.list && \
#    mv /docker-ce-archive-keyring.gpg /usr/share/keyrings/docker-ce-archive-keyring.gpg && \
#    apt-get update && \
#    apt-get install -y \
#        docker-ce-cli


#ADD busybox.tar.xz /
#RUN cp -r /usr /.usr && \
#    cp -r /etc /.etc && \
#    mv /root /.root && \
#    mv /boot /.boot && \
#    mv /run /.run && \
#    rm -rf /var/log/* \
#   rm -rf /var/lib/apt/lists/* && \
#   mv /var/ .var && \
#   mkdir -p /.root/tinySystem/usr/bin && \
#   mkdir -p /.root/tinySystem/usr/sbin && \
#   mkdir -p /.root/tinySystem/usr/lib && \
#   mkdir -p /.root/tinySystem/usr/lib64 && \
#   mkdir -p /.root/tinySystem/etc && \
#   cp /bin/rsync /.root/tinySystem/usr/bin/ && \
#   cp /bin/ldd /.root/tinySystem/usr/bin/ && \
#   mv /busybox /.root/tinySystem/usr/bin/ && \
#   for item in "$(ldd /bin/rsync /bin/ldd 2> /dev/null | awk '{print $3}' | sort -u)"; do cp $item /.root/tinySystem/usr/lib/ ;done && \
#   rsync -avzH -q --delete /.root/tinySystem/usr/ /usr/ && \
#   for item in $(/bin/busybox --list); do /bin/busybox ln -s /bin/busybox /bin/$item; done

#COPY docker-entrypoint.sh clean /
#ENTRYPOINT ["/docker-entrypoint.sh"]

















#FROM kalilinux/kali-rolling

#ENV DEBIAN_FRONTEND=noninteractive


#ADD busybox.tar.xz /
#COPY repos/sources.list-aliyun /etc/apt/sources.list
#RUN apt-get update && \
#    apt-get install --no-install-recommends -y \
#        rsync binutils libc-bin && \
#    apt-get autoclean -y && \
#    apt-get autoremove -y && \
#    cp -r /usr /.usr && \
#    cp -r /etc /.etc && \
#    mv /root /.root && \
#    mv /boot /.boot && \
#    mv /run /.run && \
#    rm -rf /var/log/* \
#    rm -rf /var/lib/apt/lists/* && \
#    mv /var/ .var && \
#    mkdir -p /.root/tinySystem/usr/bin && \
#    mkdir -p /.root/tinySystem/usr/sbin && \
#    mkdir -p /.root/tinySystem/usr/lib && \
#    mkdir -p /.root/tinySystem/usr/lib64 && \
#    mkdir -p /.root/tinySystem/etc && \
#    cp /bin/rsync /.root/tinySystem/usr/bin/ && \
#    cp /bin/ldd /.root/tinySystem/usr/bin/ && \
#    cp /bin/iconv /.root/tinySystem/usr/bin/ && \
#    cp /bin/getconf /.root/tinySystem/usr/bin/ && \
#    cp /bin/getent /.root/tinySystem/usr/bin/ && \
#    cp -r /usr/lib/*  /.root/tinySystem/usr/lib/ && \
#    cp -r /usr/lib64/* /.root/tinySystem/usr/lib64/ && \
#    mv /busybox /.root/tinySystem/usr/bin/ && \
#    for item in "$(ldd /bin/rsync /bin/ldd /bin/iconv /bin/getent /bin/getconf 2> /dev/null | awk '{print $3}' | sort -u)"; do cp $item /.root/tinySystem/usr/lib/ ;done && \
#    rsync -avzH -q --delete /.root/tinySystem/usr/ /usr/ && \
#    for item in $(/bin/busybox --list); do /bin/busybox ln -s /bin/busybox /bin/$item; done
#CMD /bin/sleep 10000

#ENTRYPOINT ["/docker-entrypoint.sh"]
