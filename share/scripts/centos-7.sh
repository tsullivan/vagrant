#!/usr/bin/env bash

set -e
set -o pipefail

yum install -y wget java

FILE=/etc/profile.d/boxname_prompt.sh
cat > $FILE <<- EOB
export PS1="centos-7:\\w$ "
EOB
