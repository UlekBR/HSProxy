#!/bin/bash


mkdir /opt
mkdir /opt/hsproxy

apt update -y && apt install curl -y

arch=$(uname -m)

if [[ $arch == "x86_64" || $arch == "amd64" || $arch == "x86_64h" ]]; then
    echo "Sistema baseado em x86_64 (64-bit Intel/AMD)"
    curl -o "/opt/hsproxy/proxy" -f "https://github.com/UlekBR/HSProxy/main/HSProxy_x64"
    curl -o "/opt/hsproxy/sslproxy" -f "https://github.com/UlekBR/HSProxy/main/HSProxySSL_x64"
    curl -o "/opt/hsproxy/menu" -f "https://github.com/UlekBR/HSProxy/main/menu_x64"
elif [[ $arch == "aarch64" || $arch == "arm64" || $arch == "armv8-a" ]]; then
    echo "Sistema baseado em arm64 (64-bit ARM)"
    curl -o "/opt/hsproxy/proxy" -f "https://github.com/UlekBR/HSProxy/main/HSProxy_arm64"
    curl -o "/opt/hsproxy/sslproxy" -f "https://github.com/UlekBR/HSProxy/main/HSProxySSL_arm64"
    curl -o "/opt/hsproxy/menu" -f "https://github.com/UlekBR/HSProxy/main/menu_arm64"
else
    echo "Arquitetura não reconhecida: $arch"
    return
fi

curl -o "/opt/hsproxy/cert.pem" -f "https://github.com/UlekBR/HSProxy/main/cert.pem"
curl -o "/opt/hsproxy/key.pem" -f "https://github.com/UlekBR/HSProxy/main/key.pem"

chmod +x /opt/api/proxy
chmod +x /opt/api/sslproxy
chmod +x /opt/api/menu

ln -s /opt/api/menu.sh /usr/local/bin/hsproxy
clear
echo -e "Para iniciar o menu digite: hsproxy"
