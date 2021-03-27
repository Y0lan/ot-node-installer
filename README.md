# ot-node-installer
> allow root connection via ssh (will be disabled later)
>  

## setup env
> export your user password: 
`export USERPASSWORD=<yourpassword>`


## configure and secure the droplet
`apt install -y curl && sh -c "$(curl -fsSL https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/more-ri.sh)"`
 

## customize the droplet for the new user
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/custom-profile.sh)"`



**reboot the server**

## configure the node
`curl -fsSL https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/setup-node.sh > $HOME/setup-node.sh && chmod +x setup-node.sh && vim setup-node.sh`

## run the node
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/backup-start.sh)"`

**enjoy the money**
