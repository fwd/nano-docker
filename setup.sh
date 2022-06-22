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
version='0.2'

# OUTPUT VARS
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
bold=`tput bold`
reset=`tput sgr0`

if [[ "$1" == "-s" ]] || [[ "$2" == "-s" ]] || [[ "$3" == "-s" ]] || [[ "$4" == "-s" ]] || [[ "$5" == "-s" ]] || [[ "$6" == "-s" ]] || [[ "$7" == "-s" ]]; then
displaySeed='true'
else
displaySeed='false'
fi

if [[ "$1" == "-q" ]] || [[ "$2" == "-q" ]] || [[ "$3" == "-q" ]] || [[ "$4" == "-q" ]] || [[ "$5" == "-q" ]] || [[ "$6" == "-q" ]] || [[ "$7" == "-q" ]]; then
quiet='true'
else
quiet='false'
fi

if [[ "$1" == "-f" ]] || [[ "$2" == "-f" ]] || [[ "$3" == "-f" ]] || [[ "$4" == "-f" ]] || [[ "$5" == "-f" ]] || [[ "$6" == "-f" ]] || [[ "$7" == "-f" ]]; then
fastSync='true'
else
fastSync='false'
fi

if [[ "$1" == "-m" ]] || [[ "$2" == "-m" ]] || [[ "$3" == "-m" ]] || [[ "$4" == "-m" ]] || [[ "$5" == "-m" ]] || [[ "$6" == "-m" ]] || [[ "$7" == "-m" ]]; then
monitor='true'
else
monitor='false'
fi

if [[ "$1" == "-p" ]] || [[ "$2" == "-p" ]] || [[ "$3" == "-p" ]] || [[ "$4" == "-p" ]] || [[ "$5" == "-p" ]] || [[ "$6" == "-p" ]] || [[ "$7" == "-p" ]] || [[ "$8" == "-p" ]]; then
    if [[ "$2" == "-p" ]]; then port=$3; fi;
    if [[ "$3" == "-p" ]]; then port=$4; fi;
    if [[ "$4" == "-p" ]]; then port=$5; fi;
    if [[ "$5" == "-p" ]]; then port=$6; fi;
    if [[ "$6" == "-p" ]]; then port=$7; fi;
    if [[ "$7" == "-p" ]]; then port=$8; fi;
    if [[ "$8" == "-p" ]]; then port=$9; fi;
fi

if [[ "$1" == "-t" ]] || [[ "$2" == "-t" ]] || [[ "$3" == "-t" ]] || [[ "$4" == "-t" ]] || [[ "$5" == "-t" ]] || [[ "$6" == "-t" ]] || [[ "$7" == "-t" ]] || [[ "$8" == "-t" ]]; then
    if [[ "$2" == "-t" ]]; then tag=$3; fi;
    if [[ "$3" == "-t" ]]; then tag=$4; fi;
    if [[ "$4" == "-t" ]]; then tag=$5; fi;
    if [[ "$5" == "-t" ]]; then tag=$6; fi;
    if [[ "$6" == "-t" ]]; then tag=$7; fi;
    if [[ "$7" == "-t" ]]; then tag=$8; fi;
    if [[ "$8" == "-t" ]]; then tag=$9; fi;
fi

if [[ "$1" == "-v" ]] || [[ "$2" == "-v" ]] || [[ "$3" == "-v" ]] || [[ "$4" == "-v" ]] || [[ "$5" == "-v" ]] || [[ "$6" == "-v" ]] || [[ "$7" == "-v" ]] || [[ "$8" == "-v" ]]; then
    if [[ "$2" == "-v" ]]; then tag=$3; fi;
    if [[ "$3" == "-v" ]]; then tag=$4; fi;
    if [[ "$4" == "-v" ]]; then tag=$5; fi;
    if [[ "$5" == "-v" ]]; then tag=$6; fi;
    if [[ "$6" == "-v" ]]; then tag=$7; fi;
    if [[ "$7" == "-v" ]]; then tag=$8; fi;
    if [[ "$8" == "-v" ]]; then tag=$9; fi;
fi

# PRINT INSTALLER DETAILS
[[ $quiet = 'false' ]] && echo ""
[[ $quiet = 'false' ]] && echo "${green}=================================${reset}"
[[ $quiet = 'false' ]] && echo "${green}${bold}1-CLICK NANO NODE ${reset}"
[[ $quiet = 'false' ]] && echo "${green}=================================${reset}"
[[ $quiet = 'false' ]] && echo "${green}${bold}by @nano2dev${reset}"
[[ $quiet = 'false' ]] && echo "${green}=================================${reset}"
# [[ $quiet = 'false' ]] && echo ""

sleep 1

# JQ used right below
if ! command -v jq &> /dev/null; then
    if [  -n "$(uname -a | grep Ubuntu)" ]; then
        echo "${CYAN}JQ:${NC}: Installing."
        sudo apt install jq -y
    else
        echo "${CYAN}Error${NC}: Could not auto install 'jq'. Please install it manually, then run ./setup.sh again."
        exit 1
    fi
fi

if [[ -z $port ]]; then port='80'; fi

if [[ -z $tag ]]; then tag=$(curl -s https://api.github.com/repos/nanocurrency/nano-node/releases/latest -s | jq .name -r); fi

# Development
# echo "quiet", $quiet
# echo "fastSync", $fastSync
# echo "monitor", $monitor
# echo "tag", $tag
# echo "port", $port
# exit 1

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

# ================================
# This is either genius or dumb. 
# ================================
# Time will tell.
DEFAULT_COMPOSE=$(cat <<EOF
version: '3'
services:
  nano-node:
    image: nanocurrency/nano:latest
    container_name: nano-node
    hostname: nano-node
    environment:
      - TERM=xterm
    restart: unless-stopped
    ports:
      - "7075:7075/udp"
      - "7075:7075"
      - "::1:7076:7076"
      - "::1:7078:7078"
    volumes:
      - ./nano-node:/root
  watchtower:
    image: v2tec/watchtower
    container_name: watchtower
    restart: unless-stopped
    command: watchtower nano-node nano-node-monitor
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
EOF
)

DOCKER_MONITOR_COMPOSE=$(cat <<EOF
  nano-node-monitor:
    image: nanotools/nanonodemonitor
    container_name: nano-node-monitor
    hostname: nano-node-monitor
    restart: unless-stopped
    volumes:
      - ./nano-node-monitor:/opt/nanoNodeMonitor
    ports:
      - "${port}:80"
EOF
)

if [ $monitor == "true" ] || [ -f ./nano-node-monitor/config.php ]; then
FINAL_COMPOSE_FILE=$(cat <<EOF
${DEFAULT_COMPOSE}
${DOCKER_MONITOR_COMPOSE}
EOF
)
else
FINAL_COMPOSE_FILE=$(cat <<EOF
${DEFAULT_COMPOSE}
EOF
)
fi

cat > docker-compose.yml <<EOF
$FINAL_COMPOSE_FILE
EOF

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

    # FAST-SYNC DOWNLOAD LINK
    # BIG THANKS TO @ThiagoSFS
    ledgerDownloadLink=$(curl -s 'https://s3.us-east-2.amazonaws.com/repo.nano.org/snapshots/latest')

    if [[ $quiet = 'false' ]]; then
        printf "=> ${yellow}Downloading latest ledger files...${reset}\n"
        wget -O todaysledger.7z ${ledgerDownloadLink} -q --show-progress
        printf "=> ${yellow}Unzipping and placing the files (takes a while)...${reset} "
        7z x todaysledger.7z  -o./nano-node/Nano -y &> /dev/null
        rm todaysledger.7z
        printf "${green}Done.${reset}\n"
        # echo ""
    else
        wget -O todaysledger.7z ${ledgerDownloadLink} -q
        docker-compose stop nano-node &> /dev/null
        7z x todaysledger.7z  -o./nano-node/Nano -y &> /dev/null
        rm todaysledger.7z
    fi

fi

# DETERMINE IF THIS IS AN INITIAL INSTALL
[[ $quiet = 'false' ]] && echo "=> ${yellow}Checking status...${reset}"
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
# [[ $quiet = 'false' ]] && echo "=> Pulling images and spinning up containers..."
# [[ $quiet = 'false' ]] && echo ""

# docker network create nano-node-network &> /dev/null

if [[ $tag ]]; then
    sed -i -e "s/    image: nanocurrency\/nano:.*/    image: nanocurrency\/nano:$tag/g" docker-compose.yml
fi

if [[ $quiet = 'false' ]]; then
    docker-compose up --remove-orphans -d
else
    docker-compose up --remove-orphans -d &> /dev/null
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

sleep 1

if [[ $quiet = 'false' && $displaySeed = 'true' ]]; then
    seed=$(${nodeExec} --wallet_decrypt_unsafe --wallet=$walletId | grep 'Seed' | awk '{ print $NF}' | tr -d '\r')
fi

if [ $monitor = 'true' ]; then

    # UPDATE MONITOR CONFIGS
    if [ ! -f ./nano-node-monitor/config.php ]; then
        [[ $quiet = 'false' ]] && echo "=> ${yellow}No existing NANO Node Monitor config file found. Fetching a fresh copy...${reset}"
        if [[ $quiet = 'false' ]]; then
            docker-compose restart nano-node-monitor
        else
            docker-compose restart nano-node-monitor > /dev/null
        fi
    fi

    # [[ $quiet = 'false' ]] && printf "=> ${yellow}Configuring NANO Node Monitor... ${reset}"

    sed -i -e "s/\/\/ \$nanoNodeRPCIP.*;/\$nanoNodeRPCIP/g" ./nano-node-monitor/config.php
    sed -i -e "s/\$nanoNodeRPCIP.*/\$nanoNodeRPCIP = 'nano-node';/g" ./nano-node-monitor/config.php

    sed -i -e "s/\/\/ \$nanoNodeAccount.*;/\$nanoNodeAccount/g" ./nano-node-monitor/config.php
    sed -i -e "s/\$nanoNodeAccount.*/\$nanoNodeAccount = '$address';/g" ./nano-node-monitor/config.php

    ipAddress=$(dig @resolver4.opendns.com myip.opendns.com +short -4)
    # ipAddress=$(curl -s v4.ifconfig.co | awk '{ print $NF}' | tr -d '\r')

    # in case of an ipv6 address, add square brackets
    if [[ $ipAddress =~ .*:.* ]]; then
        ipAddress="[$ipAddress]"
    fi

    sed -i -e "s/\/\/ \$nanoNodeName.*;/\$nanoNodeName = 'nano-docker-$ipAddress';/g" ./nano-node-monitor/config.php

    sed -i -e "s/\/\/ \$welcomeMsg.*;/\$welcomeMsg = 'Welcome! This node was setup using <a href=\"https:\/\/github.com\/fwd\/node-docker\" target=\"_blank\">Nano Docker<\/a>!';/g" ./nano-node-monitor/config.php
    
    sed -i -e "s/\/\/ \$blockExplorer.*;/\$blockExplorer = 'meltingice';/g" ./nano-node-monitor/config.php

    sed -i -e 's/\r//g' ./nano-node-monitor/config.php

fi

if [[ "$quiet" = "false" ]]; then
    echo "=========================================="
    echo "     ${green}Welcome to the Nano Blockchain${reset}         "
    echo "=========================================="

    if [[ $monitor == 'false' ]]; then
        echo "  http://$(hostname -I | cut -d' ' -f3):7676 or [::1]:7076    "
        echo "=========================================="
        else
        echo "=========================================="
        echo "  http://$(dig @resolver4.opendns.com myip.opendns.com +short -4):$port or [::1]:$port    "
        # echo "=========================================="
    fi

    if [[ $displaySeed = 'true' ]]; then
    echo "=================${yellow}SECRET${reset}==================="
    echo "${green}PUBLIC:${reset} $address"
    echo "${red}SECRET:${reset} $seed"
    echo "==============KEEP THIS SAFE=============="
    else
    echo "=================SECRET==================="
    echo "Use './setup.sh -s' to get private key.   "
    echo "=========================================="
    fi

    if [[ $displaySeed = 'false' ]]; then
    cat <<EOF
Usage:
$ nano-node --help   

Curl: 
$ curl -g -d '{ "action": "telemetry" }' '[::1]:7076'   

You might need to: source ~/.bash_aliases
EOF
    fi


    echo

fi 

# At the end for good luck.
# SET BASH ALIASES FOR NODE CLI
if [ -f ~/.bash_aliases ]; then
    alias=$(cat ~/.bash_aliases | grep 'nano-node');
    if [[ ! $alias ]]; then
        echo "alias nano-node='${nodeExec}'" >> ~/.bash_aliases;
    fi
else
    echo "alias nano-node='${nodeExec}'" >> ~/.bash_aliases;
fi

exit 1
