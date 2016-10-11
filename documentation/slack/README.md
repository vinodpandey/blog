## Creating hubot for slack
```sh
sudo npm install -g hubot coffee-script yo generator-hubot
mkdir hubot
cd hubot
yo hubot 
Bot name: elpis-bot
Bot adapter: slack

npm install hubot-slack --save

# running bot
HUBOT_SLACK_TOKEN=xoxb-xxxxxxxxxx ./bin/hubot --adapter slack
```
