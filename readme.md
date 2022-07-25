<a href="https://github.com/fwd/n1" target="_blank">
  <p align="center">
    <img src="https://github.com/fwd/n1/raw/master/.github/banner.png" alt="Prompts" width="500" />
  </p>
</a>

<h1 align="center">1-Click Nano Node</h1>

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

## ❯ Express Install

```bash

curl -L "https://github.com/fwd/nano-docker/raw/master/install.sh" | sh
```

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

## ❯ Custom Install

```bash
git clone https://github.com/fwd/nano-docker.git
```

```bash
cd nano-docker && sudo ./setup.sh -f -v V23.3 -m -p 8080
```

#### Flags
- **-f**: Enable Fast Sync (Default: True)
- **-t**: Install specific Node Version (Default: Latest)
- **-m**: Install [Node Monitor](https://github.com/NanoTools/nanoNodeMonitor) (Default: False)
- **-p**: Set Node Monitor Port (Default: 80)
- **-q**: No Console Output (Default: False)
- **-s**: Print out Private Key (Default: False)
- **-v**: Alias of **-t**

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

## Requirements

**Software:**

- Ubuntu (Supported)
- Other Linux (Coming Soon)
- Mac (Coming Soon)
- Window (Coming Soon)

**Minimum Hardware:**

- 2 vCPU
- 4GB RAM
- 160GB SSD
- 1TB BANDWIDTH
- ON 24/7

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

### Free Cloud Server \($100 / 3 Months\)

You can support Nano.to (makers of this script) by using this Digital Ocean referral link:

https://m.do.co/c/f139acf4ddcb

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

Further Reading: [How To Setup a Server on Digital Ocean](https://docs.digitalocean.com/products/droplets/how-to/create/)

---

### Understand The Magic (Optional)

This script does A LOT. It's important to understand what is happening behind the scenes. 

#### 1. Install [Docker](https://docs.docker.com/engine/install/ubuntu)

```bash
# Install Basic Tools
sudo apt-get -y jq install curl p7zip-full

# Add Docker PGP Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Remote Docker Repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Run Update (Fetch latest packages)
sudo apt-get update

# Finally, Install Docker and Dependencies.
sudo apt-get -y install jq docker-ce docker-ce-cli containerd.io
```

#### 2. Install Docker Compose

```bash
# Download latest script.
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Make it executable
sudo chmod +x /usr/local/bin/docker-compose

# Make it a global
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

#### 3. Install Nano Docker

After everything is prepared. We can finally run the script in this Repo.

```bash
# Move to HOME, and clone repo
cd ~ && git clone https://github.com/fwd/nano-docker.git

# For "Docker" reasons. We need to move in the cloned dir.
cd ~/nano-docker

# Always installs latest version
sudo ./setup.sh -s -v V23.3 -p 80
```

#### 4. Launch Node (24/7)

- Script [unlocks](https://docs.nano.org/running-a-node/wallet-setup/#update-configuration) Wallet RPC.
- Node is set up on localhost port 7076. Use '[::1]:7076' for IPv6.
- Node Websocket set up on localhost port 7078. Use '[::1]:7078' for IPv6.
- Node cannot be accessed from Internet by default. Bring your own "Proxy".

- See [setup.sh](/setup.sh) for complete setup script.
- See [docker-compose.yml](/docker-compose.yml) for network bindings created.

#### 5. Test Node

The script adds a ```nano-node``` alias to your **~/.bash_aliases** file.

```
Usage:
$ nano-node  --help
```

Or talk to the Local node with CURL.

```bash
Usage:
$ curl -g -d '{ "action": "telemetry" }' '[::1]:7076'
```

All localhost. The fastest and safest method.

## Further Reading

- [Official CLI Docs](https://docs.nano.org/commands/rpc-protocol)
- [Official Wallet RPC Docs](https://docs.nano.org/commands/rpc-protocol/#wallet-rpcs)
- [Common RPC Errors](https://docs.nano.to/rpc-errors)
- [Nano.to Docs](https://docs.nano.to)
- [More Packages](https://nano.casa)

## Nano.to Packages

- [n1 - Nano Node CLI](https://github.com/fwd/n1) - A high performance command line interface for managing Nano nodes and Nano.to.

## Community Packages

- [Full Node RPC](https://github.com/Joohansson/NanoRPCProxy) - A RPC PRoxy (w/ PoW Monetization)
- [Nault](https://github.com/Nault/Nault) - Self-Hosted Web Wallet
- [nanocurrency-js](https://github.com/marvinroger/nanocurrency-js) - Toolkit for Nano cryptocurrency client side offline integrations without requiring NodeJS functions
- [Original Node Docker](https://github.com/lephleg/nano-node-docker) - Recommended for Representative Nodes (w/ SSL)
- [Nano Vanity](https://github.com/PlasmaPower/nano-vanity) - Generate Vanity Nano Addresses
- [Node Monitor](https://github.com/NanoTools/nanoNodeMonitor) - Docs for Node Monitor.
- [Pippin Wallet](https://github.com/appditto/pippin_nano_wallet) - Enterprise Wallet (Difficulty: High).

## Credits

- [@lephleg/nano-node-docker](https://github.com/lephleg/nano-node-docker)

## Contributing

Give a ⭐️ if this project helped you!

Contributions, issues and feature requests are welcome at [issues page](https://github.com/fwd/nano-docker/issues).

## License

MIT License

Copyright © [@nano2dev](https://twitter.com/nano2dev).

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
