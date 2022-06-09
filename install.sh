cd ~
git clone https://github.com/fwd/nano-docker.git
cd ~/nano-docker
LATEST=$(curl -sL https://api.github.com/repos/nanocurrency/nano-node/releases/latest | jq -r ".tag_name")
sudo ./setup.sh -s -t $LATEST