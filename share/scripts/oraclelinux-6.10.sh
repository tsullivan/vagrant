#!/usr/bin/env bash

set -e
set -o pipefail

yum install -y tar wget java

echo "Setting up environment..."
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-0.el6_10.x86_64/jre
export JAVABIN=$JAVA_HOME/bin
export PATH=$PATH:$JAVABIN
