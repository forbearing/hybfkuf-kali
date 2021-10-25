#!/usr/bin/env bash
# ref:
#   https://www.kali.org/docs/general-use/xfce-with-rdp/
#   https://www.kali.org/docs/general-use/novnc-kali-in-browser/
#   https://unix.stackexchange.com/questions/562547/how-to-force-x11vnc-to-use-xfce
#   https://dog.wtf/tech/run-kali-in-docker-and-install-desktop-environment-and-vnc/


echo -e "\n***** sysinit *****\n"
export SHELL="/bin/bash"        # novnc 默认使用 sh，在此设置为 bash
export USER="root"              # vnc 依赖 $USER 变量
[[ ${ROOT_PASSWD} ]] || export ROOT_PASSWD="toor"
[[ ${VNC_PASSWD} ]] || export VNC_PASSWD="toor"
[[ ${VNC_GEOMETRY} ]] || export VNC_GEOMETRY="1280x720"
echo ${VNC_GEOMETRY}


# start ssh
echo -e "\n***** start ssh *****\n"
cat > /etc/ssh/sshd_config <<-EOF
Include /etc/ssh/sshd_config.d/*.conf
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
PermitRootLogin yes
EOF
mkdir -p /run/sshd
/usr/sbin/sshd &
echo "root:${ROOT_PASSWD}" | chpasswd


# locales
#echo -e "\n***** generate locale *****\n"
#dpkg-reconfigure locales


# start xrdp
echo -e "\n***** start xrdp *****\n"
service xrdp restart


## start x11vnc
#echo -e "\n***** start x11vnc *****\n"
#/usr/bin/x11vnc -display :0 -autoport -localhost -nopw -bg -xkb -ncache -ncache_cr -quiet -forever -create &       # no passwd
#vncport=$( ss -luntp | grep x11vnc | awk '{print $5}' | awk -F':' '{print $NF}' | sed -n '1,1p')

# start tightvncserver
# ref: https://en.wikipedia.org/wiki/Graphics_display_resolution
# geometry: e.g. 1280x720, 1600x900, 1920x1080
echo -e "\n***** start tightvncserver *****"
mkdir -p /root/.vnc
echo ${VNC_PASSWD} | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd
count=0
while true; do
    if vncserver :$count -geometry ${VNC_GEOMETRY}; then
        break; fi
    (( count++ ))
    sleep 1
done
vncport=$(ss -luntp | grep Xtightvnc | awk '{print $5}' | awk -F':' '{print $NF}' | grep '^5' | sed -n '1,1p')

# start novnc
echo -e "\n***** start noVNC *****\n"
#/usr/share/novnc/utils/launch.sh --listen 8081 --vnc localhost:5900 &
/usr/share/novnc/utils/launch.sh --listen 8081 --vnc localhost:$vncport &

# history
history -c
history -w


#echo -e  "\n***** startxfce4 *****\n"
#/usr/bin/startxfce4 &

while true; do
    sleep 1000
done

#x11vnc -display :0 -autoport -localhost -nopw -bg -xkb -ncache -ncache_cr -quiet -forever
#/usr/share/novnc/utils/launch.sh --listen 8081 --vnc localhost:5900
