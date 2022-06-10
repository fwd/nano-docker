<a href="https://github.com/fwd/n2" target="_blank">
  <p align="center">
    <img src="https://github.com/fwd/n2/raw/master/.github/banner.jpg" alt="Prompts" width="500" />
  </p>
</a>

<h1 align="center">1-Click <a href="https://docs.nano.org/running-a-node/overview/" target="_blank">Nano Node</a></h1>

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

## ❯ Install

```bash

curl -L "https://github.com/fwd/nano-docker/raw/master/install.sh" | sh
```

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

## Understand The Magic (Optional)

This script does A LOT. It's important to understand what is happening behind the scenes. 

### 1. Installs [Docker](https://docs.docker.com/engine/install/ubuntu)

```bash
# Install Basic Tools
sudo apt-get -y jq install curl p7zip-full

# Install Docker PGP Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Remote Docker Repo Machine
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Run Update (Fetch latest packages)
sudo apt-get update

# Finally, Install Docker and Dependencies.
sudo apt-get -y install jq docker-ce docker-ce-cli containerd.io
```

### Installs Docker Compose

```bash
# Download latest script.
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Make it executable
sudo chmod +x /usr/local/bin/docker-compose

# Make it a global command
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

### Install Nano Docker

Finally, after all the needed tools are installed. We can run the actual script on this Repo.

```bash
# Move to HOME folder
cd ~

# Clone this Repo
git clone https://github.com/fwd/nano-docker.git

# For "Docker" reasons. We need to move in the cloned dir.
cd ~/nano-docker

# Finall,y run the setup script
sudo ./setup.sh -s -t V23.1
```

### Launch Node

The ```./setup.sh``` contains the logic to launch Node with Docker.

- Script Unlocks Wallet RPC
- Node Accessible @ http://localhost:7076 or [::1]:7076 for IPv6.
- SSL is NOT installed. 
- ```nano-node``` is added to ~/.bash_aliases

## Test Node

You can talk to the Local node with CURL

```bash
curl -g -d '{ "action": "telemetry" }' '[::1]:7076'
```

## Contributing

Give a ⭐️ if this project helped you!

Contributions, issues and feature requests are welcome at [issues page](https://github.com/fwd/nano-docker/issues).

## ❯ License

MIT License

Copyright © 2022 [@nano2dev](https://twitter.com/nano2dev).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## ❯ Stargazers

[![Stargazers over time](https://starchart.cc/fwd/nano-docker.svg)](https://starchart.cc/fwd/nano-docker)
