#!/bin/bash -ex
sudo apt-get install pass

LATEST_VERSION=$(curl -Ls https://api.github.com/repos/docker/docker-credential-helpers/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
curl -LO "https://github.com/docker/docker-credential-helpers/releases/download/$LATEST_VERSION/docker-credential-pass-$LATEST_VERSION-amd64.tar.gz"
tar xvf "docker-credential-pass-$LATEST_VERSION-amd64.tar.gz"
sudo mv docker-credential-pass /usr/local/bin

gpg2 --batch --gen-key <<-EOF
%echo Generating a standard key
Key-Type: DSA
Key-Length: 1024
Subkey-Type: ELG-E
Subkey-Length: 1024
Name-Real: Christoph Diehl
Name-Email: cdiehl@mozilla.com
Expire-Date: 0
%commit
%echo done
EOF

key=$(gpg --no-auto-check-trustdb --list-secret-keys | grep ^sec | cut -d/ -f2 | cut -d" " -f1)
pass init "$key"

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin