# AMAZING OT NODE INSTALLER
soon to be added: 

telegram notification for storage space &
automatic security update

## PERFECT SERVER WITH
### USER COMFORT
#### OH MY ZSH
![](https://blog.amd-nick.me/content/images/2018/12/logo-ohmyzsh-ce68f7c0711473bb619d23b1ce1e3a6e53895cd7cc56eb8af57d8076d1928759.png)
![](https://i.imgur.com/IT93PZR.png)

#### GTOP
![gtop](https://www.cyberciti.biz/media/new/cms/2017/12/gtop-outputs.jpg "gtop")

#### CUSTOM VIM
![vim](https://i.imgur.com/emovGze.png "vim")

### SERVER SECURITY

- NO ROOT LOGIN
- USER WITH SUDO 
- FIREWALL TO BLOCK ALL NON ESSENTIAL PORT
- FAIL2BAN
- ENCRYPTED BACKUP OF YOUR NODE in `~/backup.zip`
- DOCKER RESTART

## HOW TO SETUP - DIGITAL OCEAN - DEBIAN 10 - XDAI

![](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.ytimg.com%2Fvi%2FqXlU3bRKblI%2Fmaxresdefault.jpg&f=1&nofb=1)
![](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fsoftwareengineeringdaily.com%2Fwp-content%2Fuploads%2F2017%2F10%2Fdigitalocean.png&f=1&nofb=1)
### 1 . METAMASK
![](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fbitcoinexchangeguide.com%2Fwp-content%2Fuploads%2F2017%2F06%2Fmetamask.jpg&f=1&nofb=1)

Make two account
-    account 1:for withdrawing the reward 
- account 2:  for the node 

Next you will need:
##### NODE_PRIVATE_KEY
- private **(without 0x in front of it)** of **account 2** 
##### NODE_PUBLIC
- public key of **account 2** 
##### MANAGEMENT_WALLET_PUBLIC
- public key of **account 1** 
##### INITIAL_DEPOSIT_AMOUNT
- the amount of xtrac you will send from account 1 to account 2 followed by 18 zeros
> 5000 XTRAC SENT = 5000000000000000000000


---




### 2 . SEND 2XDAI / 5000 XTRAC TO ACCOUNT 2 VIA METAMASK
![xdai](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmasterethereum.com%2Fwp-content%2Fuploads%2F2020%2F10%2FxDAI-Master-Blockchain-Online.jpg&f=1&nofb=1 "xdai")

---
### 3. PREPARE THE SERVER WITH ALL THE SOFTWARE

1. ssh into your server with root@ip

2. choose the password for your user (for sudo)
` export USERPASSWORD=<yourpassword> `

3. run this script
`apt install -y curl && sh -c "$(curl -fsSL https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/more-ri.sh)"`
---

### 4. SETUP OH MY ZSH / VIM FOR THE NEW USER
#### Install oh-my-zsh + theme your shell + theme vim + reboot to finalize step 3

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/custom-profile.sh)" && sudo reboot`

---
### 5. SETUP THE NODE
**You can SSH with login : user-\<your hostname>@ip**

##### GET THE INFO FROM STEP 1
##### NODE_PRIVATE_KEY
- private **(without 0x in front of it)** of **account 2** 
##### NODE_PUBLIC
- public key of **account 2** 
##### MANAGEMENT_WALLET_PUBLIC
- public key of **account 1** 
##### INITIAL_DEPOSIT_AMOUNT
- the amount of xtrac you will send from account 1 to account 2 followed by 18 zeros
> 5000 XTRAC SENT = 5000000000000000000000

##### RUN THIS AND MODIFY THE INFORMATION ACCORDINGLY 
###### modify VIM in the command below to nano if you are not comfortable with vim


`curl -fsSL https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/setup-node.sh > $HOME/setup-node.sh && chmod +x setup-node.sh && vim setup-node.sh`

Once the information are in the script, run it...

`./setup-node.sh`

---
### 6. LAUNCH THE NODE
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/backup-start.sh)"`

💰💰💰💰💰💰💰💰💰💰💰💰



