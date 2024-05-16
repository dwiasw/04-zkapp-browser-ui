#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 && sleep 1

NODE="initia"
export DAEMON_HOME=$HOME/.initia
export DAEMON_NAME=initiad
CHAIN_ID="initiation-1"
if [ -d "$DAEMON_HOME" ]; then
    new_folder_name="${DAEMON_HOME}_$(date +"%Y%m%d_%H%M%S")"
    mv "$DAEMON_HOME" "$new_folder_name"
fi
#echo 'export CHAIN_ID='\"${CHAIN_ID}\" >> $HOME/.bash_profile

if [ ! $VALIDATOR ]; then
    read -p "Enter validator name: " VALIDATOR
    echo 'export VALIDATOR='\"${VALIDATOR}\" >> $HOME/.bash_profile
fi
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
source $HOME/.bash_profile
sleep 1
cd $HOME
sudo apt update
sudo apt install make unzip clang pkg-config lz4 libssl-dev build-essential git jq ncdu bsdmainutils htop -y < "/dev/null"

echo -e '\n\e[42mInstall Go\e[0m\n' && sleep 1
cd $HOME
VERSION=1.22.3
wget -O go.tar.gz https://go.dev/dl/go$VERSION.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.tar.gz && rm go.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version

echo -e '\n\e[42mInstall software\e[0m\n' && sleep 1

sleep 1
cd $HOME
rm -rf initia
git clone https://github.com/initia-labs/initia.git
cd initia
git checkout v0.2.14
make build
sudo mv build/initiad /usr/local/bin/
source .profile
PEERS="f32dd215fe0c3383f26c595bc229670ed26cd6dd@212.64.217.208:15656,132018cac831b576d2f3662fd528fe9120e3d0a2@65.108.254.0:26656,2692225700832eb9b46c7b3fc6e4dea2ec044a78@34.126.156.141:26656,fd06e3e5f03b31757ee2ce78d0bf85bb1c71a2d9@65.109.166.136:26656,d5b1df79a57c73d4191de973846671b57da68cdf@194.163.130.254:26656,9228bbd89be619dd943e44633585c1657051a7d0@173.212.193.103:17956,028999a1696b45863ff84df12ebf2aebc5d40c2d@37.27.48.77:26656,cf434216cedcd589c59197ab11a92c251e0e542a@139.59.247.242:26656,d43f10aea1629afb65abf63993b7fed64be2c7cd@93.159.130.38:41656,f7102125c08191854a436458dcd06c187c2372d5@89.58.28.79:12656,ab440843d410f0fdfe8aee8379fd0c342e45e448@161.97.107.208:17956,277ae7258c9ac789262ef125cfdbf1c02958510a@37.27.71.199:22656,ae241bcfd5fffef3173c5bd4c72b0b384db5db88@49.13.213.52:26656,848abf8efb7e91adeb526f15ac9561d87d6a2325@84.46.255.1:17956,32fece76b6d278672fb73059764f5d6f77086f3a@148.251.3.125:19656,fa69efe26762f987a1e1eaf4ea053b35380838dc@80.65.211.232:17956,591cf89ddadedc89df0973a3d2a7bf5a9b5fa775@95.217.228.108:17956,0d236f1685afac05769889b2fcd9fc6ff75edb61@116.202.85.52:17956,7e4082fd1eafb7d7310003137bfdb61fdf719209@15.235.218.25:19656,32f59b799e6e840fb47b363ba59e45c3519b3a5f@136.243.104.103:24556,5c2a752c9b1952dbed075c56c600c3a79b58c395@195.3.221.9:26686,1702812bd704cb71b5467e0aa2db0080f1a98e3f@195.201.1.240:26656,be91b43e35e79fba3f12b67f82a80016a5cb5e63@45.76.163.204:26656,1813a8de79d48674f184553800122f7bf794cd57@213.199.52.16:26656,22c876f711032026c54d2ccfe81cb2cfe1ec9ac1@37.60.243.170:26656,2f7f232a67544d604773dab3f92fb51361b9d0d0@65.109.236.170:17656,a633694e4f10060023b3c8319ae130fa927f706b@207.180.251.85:17956,5f934bd7a9d60919ee67968d72405573b7b14ed0@65.21.202.124:29656,15a9693fbcdd9d8aea48030be3b520b1d69e8d66@193.34.213.228:14656,98f0f8e9209aa0a8abad39b94b0d2663a3be24ec@95.216.70.202:26656,8999ddce339185140913a64c623d0cb2a0e104f5@185.202.223.117:17956,670d532665a0f93ccbba6d132109c207301d6353@194.163.170.113:17956,7d097908682ef4f4e168f2136da2612ec43da27c@85.215.181.21:26656,e44e11c6f229a571f4239781f249a25e4257c179@185.84.224.160:25756,a3f2bd6fcf79eec06a5f384b3edaf1fe6e4ac9ce@82.208.22.54:17956,6ba38c13353dc4c441b3e3861494420a925f2a94@149.102.152.191:17956,0ca1eb793296bda62e71c515b42027ae2a27c5de@43.134.3.197:27656,2bc4ca9a821b56e5786378a4167c57ef6e0d174f@167.235.200.43:17956,7cc821219468db81e2b62bcafcd4f17ae1e577b1@49.13.12.207:17956,872c3ae2afa513f18ee5ef5a56f65d4053c337c5@95.216.142.239:26656,cd69bcb00a6ecc1ba2b4a3465de4d4dd3e0a3db1@65.108.231.124:51656,f74fc6b67aa5bed0ed29b81fc2a86809358a1acf@62.169.28.193:17956,23251217584bc066c8027cc735ca1b2893896178@185.197.251.195:17956,40d3f977d97d3c02bd5835070cc139f289e774da@168.119.10.134:26313,841c6a4b2a3d5d59bb116cc549565c8a16b7fae1@23.88.49.233:26656,e6a35b95ec73e511ef352085cb300e257536e075@37.252.186.213:26656,2a574706e4a1eba0e5e46733c232849778faf93b@84.247.137.184:53456,ff9dbc6bb53227ef94dc75ab1ddcaeb2404e1b0b@178.170.47.171:26656,edcc2c7098c42ee348e50ac2242ff897f51405e9@65.109.34.205:36656,07632ab562028c3394ee8e78823069bfc8de7b4c@37.27.52.25:19656,028999a1696b45863ff84df12ebf2aebc5d40c2d@37.27.48.77:26656,140c332230ac19f118e5882deaf00906a1dba467@185.219.142.119:53456,1f6633bc18eb06b6c0cab97d72c585a6d7a207bc@65.109.59.22:25756,065f64fab28cb0d06a7841887d5b469ec58a0116@84.247.137.200:53456,767fdcfdb0998209834b929c59a2b57d474cc496@207.148.114.112:26656,093e1b89a498b6a8760ad2188fbda30a05e4f300@35.240.207.217:26656,12526b1e95e7ef07a3eb874465662885a586e095@95.216.78.111:26656"
SEEDS="2eaa272622d1ba6796100ab39f58c75d458b9dbc@34.142.181.82:26656,c28827cb96c14c905b127b92065a3fb4cd77d7f6@testnet-seeds.whispernode.com:25756"
$DAEMON_NAME init "${VALIDATOR}" --chain-id $CHAIN_ID
sleep 1
$DAEMON_NAME config set client chain-id $CHAIN_ID
$DAEMON_NAME config set client keyring-backend test

wget -O $DAEMON_HOME/config/genesis.json https://raw.githubusercontent.com/initia-labs/networks/main/initiation-1/genesis.json
sed -i.bak -e "s/^seeds *=.*/seeds = \"${SEEDS}\"/" $DAEMON_HOME/config/config.toml
sed -i -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $DAEMON_HOME/config/config.toml
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.15uinit,0.01uusdc\"|" $DAEMON_HOME/config/app.toml
sed -i -e 's/external_address = \"\"/external_address = \"'$(curl httpbin.org/ip | jq -r .origin)':26656\"/g' $DAEMON_HOME/config/config.toml
#PRUNING
sed -i "s/pruning *=.*/pruning = \"custom\"/g" $DAEMON_HOME/config/app.toml
sed -i "s/pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/g" $DAEMON_HOME/config/app.toml
sed -i "s/pruning-interval *=.*/pruning-interval = \"19\"/g" $DAEMON_HOME/config/app.toml
sed -i -e "s/indexer *=.*/indexer = \"null\"/g" $DAEMON_HOME/config/config.toml

echo "[Unit]
Description=$NODE Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/$DAEMON_NAME start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/$DAEMON_NAME.service
sudo mv $HOME/$DAEMON_NAME.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF

echo -e '\n\e[42mDownloading a snapshot\e[0m\n' && sleep 1
#curl https://snapshots.kjnodes.com/initia-testnet/snapshot_latest.tar.lz4 -O snapshot_latest.tar.lz4 | lz4 -dc - | tar -xf - -C $DAEMON_HOME
curl -o - -L https://snapshots.kjnodes.com/initia-testnet/snapshot_latest.tar.lz4 -O snapshot_latest.tar.lz4 | lz4 -c -d - | tar -x -C $DAEMON_HOME
wget -O $DAEMON_HOME/config/addrbook.json https://snapshots.kjnodes.com/initia-testnet/addrbook.json

echo -e '\n\e[42mChecking a ports\e[0m\n' && sleep 1
#CHECK PORTS
PORT=337
if ss -tulpen | awk '{print $5}' | grep -q ":26656$" ; then
    echo -e "\e[31mPort 26656 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:26656\"|:${PORT}56\"|g" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 26656 changed to ${PORT}56.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":26657$" ; then
    echo -e "\e[31mPort 26657 already in use\e[39m"
    sleep 2
    sed -i -e "s|:26657\"|:${PORT}57\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 26657 changed to ${PORT}57.\e[0m\n"
    sleep 2
    $DAEMON_NAME config set client node tcp://localhost:${PORT}57
fi
if ss -tulpen | awk '{print $5}' | grep -q ":26658$" ; then
    echo -e "\e[31mPort 26658 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:26658\"|:${PORT}58\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 26658 changed to ${PORT}58.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":6060$" ; then
    echo -e "\e[31mPort 6060 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:6060\"|:${PORT}60\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 6060 changed to ${PORT}60.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":1317$" ; then
    echo -e "\e[31mPort 1317 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:1317\"|:${PORT}17\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 1317 changed to ${PORT}17.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":9090$" ; then
    echo -e "\e[31mPort 9090 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:9090\"|:${PORT}90\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 9090 changed to ${PORT}90.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":9091$" ; then
    echo -e "\e[31mPort 9091 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:9091\"|:${PORT}91\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 9091 changed to ${PORT}91.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":8545$" ; then
    echo -e "\e[31mPort 8545 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:8545\"|:${PORT}45\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 8545 changed to ${PORT}45.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":8546$" ; then
    echo -e "\e[31mPort 8546 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:8546\"|:${PORT}46\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 8546 changed to ${PORT}46.\e[0m\n"
    sleep 2
fi

#echo -e '\n\e[42mRunning a service\e[0m\n' && sleep 1
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable $DAEMON_NAME
sudo systemctl restart $DAEMON_NAME


echo -e '\n\e[42mCheck node status\e[0m\n' && sleep 1
if [[ `service $DAEMON_NAME status | grep active` =~ "running" ]]; then
  echo -e "Your $DAEMON_NAME node \e[32minstalled and works\e[39m!"
  echo -e "You can check node status by the command \e[7mservice $DAEMON_NAME status\e[0m"
  echo -e "Press \e[7mQ\e[0m for exit from status menu"
else
  echo -e "Your $NODE node \e[31mwas not installed correctly\e[39m, please reinstall."
fi

