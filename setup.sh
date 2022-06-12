#!/bin/bash

#################################################
#  NANO Node Docker                             #
#  https://github.com/lephleg/nano-node-docker  #
#################################################

#################################################
#  Modified by @nano2dev                        #
#  https://github.com/fwd/nano-docker           #
#################################################

# VERSION
version='0.1'

# FAST-SYNC DOWNLOAD LINK
ledgerDownloadLink="https://s3.us-east-2.amazonaws.com/repo.nano.org/snapshots/Nano_64_2022_05_28_22.7z"
# ledgerDownloadLink="https://s3.us-east-2.amazonaws.com/repo.nano.org/snapshots/Nano_64_$(date +%Y)_01_20_23.7z"

# OUTPUT VARS
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
bold=`tput bold`
reset=`tput sgr0`

# FLAGS & ARGUMENTS
quiet='false'
displaySeed='false'
fastSync='false'
domain=''
email=''
tag=''
while getopts 'sqfd:e:t:' flag; do
  case "${flag}" in
    s) displaySeed='true' ;;
    d) domain="${OPTARG}" ;;
    e) email="${OPTARG}" ;;
    q) quiet='true' ;;
    f) fastSync='true' ;;
    t) tag="${OPTARG}" ;;
    *) exit 1 ;;
  esac
done

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo ""
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Operating system not supported."
    exit 1
  # Mac OSX
elif [[ "$OSTYPE" == "cygwin" ]]; then
    echo "Operating system not supported."
    exit 1
  # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
    echo "Operating system not supported."
    exit 1
  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
  # I'm not sure this can happen.
    echo "Operating system not supported."
    exit 1
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  # ...
    echo "Operating system not supported."
    exit 1
else
   # Unknown.
    echo "Operating system not supported."
    exit 1
fi

echo $@ > settings

# PRINT INSTALLER DETAILS
[[ $quiet = 'false' ]] && echo "${green}=================================${reset}"
[[ $quiet = 'false' ]] && echo "${green}${bold} 1-CLICK NANO NODE ${reset}"
[[ $quiet = 'false' ]] && echo "${green}=================================${reset}"
[[ $quiet = 'false' ]] && echo "${green}${bold}    by @nano2dev ${reset}"
[[ $quiet = 'false' ]] && echo "${green}=================================${reset}"
[[ $quiet = 'false' ]] && echo ""

sleep 1

# VERIFY TOOLS INSTALLATIONS
docker -v &> /dev/null
if [ $? -ne 0 ]; then

    echo "Installing Docker"

    # Docs: https://docs.docker.com/engine/install/ubuntu

    # Basics
    sudo apt-get -y install curl p7zip-full

    # PGP Key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Set up Docker Repo
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt-get update
    
    sudo apt-get -y install jq docker-ce docker-ce-cli containerd.io

fi

docker-compose --version &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing Docker Compose"
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

if [[ $tag == '' ]]; then
    echo "${yellow}Nano node image tag is now required. Please set the -t argument explicitly to the version you are willing to install (https://hub.docker.com/r/nanocurrency/nano/tags).${reset}"
    exit 2
fi

if [[ $fastSync = 'true' ]]; then
    wget --version &> /dev/null
    if [ $? -ne 0 ]; then
        echo "${red}wget is not installed and is required for fast-syncing.${reset}";
        exit 2
    fi

    7z &> /dev/null
    if [ $? -ne 0 ]; then
        echo "${red}7-Zip is not installed and is required for fast-syncing.${reset}";
        exit 2
    fi
fi

# FAST-SYNCING
if [[ $fastSync = 'true' ]]; then

    if [[ $quiet = 'false' ]]; then
        printf "=> ${yellow}Downloading latest ledger files for fast-syncing...${reset}\n"
        wget -O todaysledger.7z ${ledgerDownloadLink} -q --show-progress

        printf "=> ${yellow}Unzipping and placing the files (takes a while)...${reset} "
        7z x todaysledger.7z  -o./nano-node/Nano -y &> /dev/null
        rm todaysledger.7z
        printf "${green}done.${reset}\n"
        echo ""

    else
        wget -O todaysledger.7z ${ledgerDownloadLink} -q
        docker-compose stop nano-node &> /dev/null
        7z x todaysledger.7z  -o./nano-node/Nano -y &> /dev/null
        rm todaysledger.7z
    fi

fi

# DETERMINE IF THIS IS AN INITIAL INSTALL
[[ $quiet = 'false' ]] && echo "=> ${yellow}Checking initial status...${reset}"
[[ $quiet = 'false' ]] && echo ""

# check if node mounted directory exists
if [ -d "./nano-node" ]; then
    # check if mounted directory follows the new /root structure
    if [ ! -d "./nano-node/RaiBlocks" ]; then
        if [ ! -d "./nano-node/Nano" ]; then
            [[ $quiet = 'false' ]] && printf "${reset}Unsupported directory structure detected. Migrating files... "
            mkdir ./nano-node/RaiBlocks
            # move everything into subdirectory and suppress the error about itself
            mv ./nano-node/* ./nano-node/RaiBlocks/ &> /dev/null
            [[ $quiet = 'false' ]] && printf "${green}done.\n${reset}"
            [[ $quiet = 'false' ]] && echo ""
        fi
    fi
fi

# SPIN UP THE APPROPRIATE STACK
[[ $quiet = 'false' ]] && echo "=> Pulling images and spinning up containers..."
[[ $quiet = 'false' ]] && echo ""

docker network create nano-node-network &> /dev/null

if [[ $tag ]]; then
    sed -i -e "s/    image: nanocurrency\/nano:.*/    image: nanocurrency\/nano:$tag/g" docker-compose.yml
fi

if [[ $quiet = 'false' ]]; then
    docker-compose up -d
else
    docker-compose up -d &> /dev/null
fi

if [ $? -ne 0 ]; then
    echo "${red}It seems errors were encountered while spinning up the containers. Scroll up for more info on how to fix them.${reset}"
    exit 2
fi

isRpcLive="$(curl -s -d '{"action": "version"}' [::1]:7076 | grep "rpc_version")"
while [ ! -n "$isRpcLive" ];
do
    sleep 1s
    isRpcLive="$(curl -s -d '{"action": "version"}' [::1]:7076 | grep "rpc_version")"
done

nodeExec="docker exec -it nano-node /usr/bin/nano_node"

# SET BASH ALIASES FOR NODE CLI
if [ -f ~/.bash_aliases ]; then
    alias=$(cat ~/.bash_aliases | grep 'nano-node');
    if [[ ! $alias ]]; then
        echo "alias nano-node='${nodeExec}'" >> ~/.bash_aliases;
    fi
else
    echo "alias nano-node='${nodeExec}'" >> ~/.bash_aliases;
fi

sleep 1

source ~/.bash_aliases;

# WALLET SETUP
sed -i 's/enable_control = false/enable_control = true/g' ~/nano-docker/nano-node/Nano/config-rpc.toml

existedWallet="$(${nodeExec} --wallet_list | grep 'Wallet ID' | awk '{ print $NF}')"

if [[ ! $existedWallet ]]; then
    # [[ $quiet = 'false' ]] && printf "=> No wallet found. Generating a new one..."
    walletId=$(${nodeExec} --wallet_create | tr -d '\r')
    sleep 1
    address="$(${nodeExec} --account_create --wallet=$walletId | awk '{ print $NF}')"
    sleep 1
    [[ $quiet = 'false' ]] && printf "${green}done.${reset}\n\n"
else
    # [[ $quiet = 'false' ]] && echo "=> ${yellow}Existing wallet found.${reset}"
    # [[ $quiet = 'false' ]] && echo ''
    address="$(${nodeExec} --wallet_list | grep 'nano_' | awk '{ print $NF}' | tr -d '\r')"
    sleep 1
    walletId=$(echo $existedWallet | tr -d '\r')
fi

echo "=========================================="
echo "        Welcome to the Blockchain         "
echo "=========================================="
echo "   http://localhost:7676 or [::1]:7076    "
echo "=========================================="
cat <<EOF

Usage:
$ nano-node --help   

Curl
$ curl -g -d '{ "action": "telemetry" }' '[::1]:7076'                         
EOF
