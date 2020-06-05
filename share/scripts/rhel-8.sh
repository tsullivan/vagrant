#!/usr/bin/env bash

set -e
set -o pipefail

yum install -y wget tar
alternatives --set python /usr/bin/python3

# EPEL
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# for reporting
yum install -y xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc fontconfig freetype

FILE=/etc/profile.d/boxname_prompt.sh
cat > $FILE <<- EOB
export PS1="rhel8:\\w$ "
EOB
