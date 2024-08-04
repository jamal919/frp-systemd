#!/bin/bash

indir=/opt/frp 

# detecting os/kernel
echo -n "System: "
os=`uname -s | tr [:upper:] [:lower:]`
if [ ! $os == linux ]; then
    echo "Not , exiting..."
    exit
else
    echo -n " linux | "
fi

# detecting
arch=$(uname -m)
case $arch in
    "x86_64")
        arch="amd64"
        ;;
    "armv7l")
        arch="arm"
        ;;
    "aarch64")
        arch="arm64"
        ;;
    *)
        echo " unknown architecture"
        echo "Check frp github page - https://github.com/fatedier/frp"
        exit
        ;;
esac
echo " $arch"

# user-query about config
echo "Have you updated the configs (frpc/frps.toml)?"
select yn in "Yes" "No"; do
    case $yn in
        "Yes") 
            break
            ;;
        "No")
            echo "Nothing installed. Exiting."
            exit
            ;;
        *) 
            echo "Select from one of the above by number"
            ;;
    esac
done

# download and installing
download_url=`curl -s https://api.github.com/repos/fatedier/frp/releases/latest | grep "browser_download_url" | grep $os | grep $arch | cut -d : -f2-3 | tr -d \"`

echo "Source: ${download_url}"

if [ ! -d $indir ]; then
    sudo mkdir $indir
fi
echo "Installing into $indir"
wget -qO- $download_url | sudo tar xzf - --strip-component=1 -C $indir

# copying configurations
echo "Copying configurations..."
sudo cp -v frps.toml $indir/frps.toml 
sudo cp -v frpc.toml $indir/frpc.toml

# creating service
echo "Installing services..."
sudo cp -v frps.service /lib/systemd/system/frps.service
sudo cp -v frpc.service /lib/systemd/system/frpc.service

# message
echo "Activate and enable services using - sudo systemctl enable/start frp[c/s].service"
echo "Check README.md for further detail."
echo "󰩑 Bye..."
