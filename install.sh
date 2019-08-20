et -e
currentUser=`whoami`
echo ${currentUser}
sudo apt-get update
sudo apt-get install curl
sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs git
sudo npm i pm2 -g
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ${currentUser} --hp ${HOME}
sudo mkdir -p /opt/app
sudo rm -rf /opt/app/router
sudo mkdir -p /opt/config
sudo chown -R ${currentUser}:${currentUser} /opt/app
sudo chown -R ${currentUser}:${currentUser} /opt/config
cd /opt/app
git clone https://github.com/vzakharchenko/smartthings_asus_router router
cp -n /opt/app/router/config/config.json /opt/config/routerConfig.json
cd router
npm i
cd router-ui
npm i
npm build:prod
cd ..
pm2 start AsusSmartAppServer.js
pm2 save
