#!/usr/bin/env bash

set -e
set -o pipefail

yum install -y wget java tar

FILE=/etc/profile.d/boxname_prompt.sh
cat > $FILE <<- EOB
export PS1="ol-6.10:\\w$ "
EOB
