<a href="https://github.com/fwd/n2" target="_blank">
  <p align="center">
    <img src="https://github.com/fwd/n2/raw/master/.github/banner.png" alt="n2" width="450" />
  </p>
</a>

<h1 align="center">1-Click Nano Node</h1>

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

## ❯ Express

```bash
curl -L "https://fwd.github.io/nano-docker/install.sh" | sh
```

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

## ❯ Custom

```bash
git clone https://github.com/fwd/nano-docker.git
```

```bash
cd nano-docker && sudo ./setup.sh -f -t V23.1 -m -p 8080
```

> Latest Nano Node V23.3 is unable to self sync. We recommend installing V23.1 for syncing. Run './setup.sh -t V23.3' after syncing, to upgrade.

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

https://m.do.co/c/f139acf4ddcb

> Supports Nano.to (makers of this script)

![line](https://github.com/fwd/n2/raw/master/.github/line.png)

Optional Reading: [How To Setup a Server on Digital Ocean](https://docs.digitalocean.com/products/droplets/how-to/create/)

---

### Understand The Magic (Optional)

#### 1. Install [Docker](https://docs.docker.com/engine/install/ubuntu)

```bash
# Install Basic Tools
sudo apt-get -y install jq curl p7zip-full

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

```bash
# Move to HOME, and clone repo
cd ~ && git clone https://github.com/fwd/nano-docker.git

# For "Docker" reasons. We need to move in the cloned dir.
cd ~/nano-docker

# Leave -v blank for latest version
sudo ./setup.sh -s
```

#### 4. Configure Node

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

```bash
Usage:
$ curl -g -d '{ "action": "version" }' '[::1]:7076'
$ curl -g -d '{ "action": "block_count" }' '[::1]:7076'
$ curl -g -d '{ "action": "block_count" }' '[::1]:7076'
$ curl -g -d '{ "action": "telemetry" }' '[::1]:7076'
```

## Further Reading

- [Official CLI Docs](https://docs.nano.org/commands/rpc-protocol)
- [Official Wallet RPC Docs](https://docs.nano.org/commands/rpc-protocol/#wallet-rpcs)
- [Common RPC Errors](https://docs.nano.to/rpc-errors)
- [Nano.to Docs](https://docs.nano.to)
- [**More Packages**](https://github.com/fwd/nano-packages)

## Contributing

Give a ⭐️ if this project helped you!

Contributions, issues and feature requests are welcome at [issues page](https://github.com/fwd/nano-docker/issues).

## License

MIT License

Copyright [@nano2dev](https://twitter.com/nano2dev).

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
