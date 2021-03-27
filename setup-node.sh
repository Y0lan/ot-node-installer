#!/bin/bash



########### NODE CONFIGURATION ################
# MAX JOB TIME
HOLDING_TIME=215000 # 6 MONTHS

# The lower the value, the less paid jobs you are willing to accept (RECOMMENDED < 1)
DH_PRICE_FACTOR=0.1
###############################################


########## CHANGE THIS #######################


CONFIG_FILE=$HOME/.origintrail_noderc 
BACKUP_FOLDER=$HOME/backup-$HOSTNAME


# NODE PUBLIC ADDRESS WITHOUT 0X
NODE_PUBLIC=0
# NODE PRIVATE KEY
NODE_PRIVATE_KEY=0
# OTHER WALLET TO CASH OUT PUBLIC ADDRESS
MANAGEMENT_WALLET_PUBLIC=0
# THE AMOUNT OF XTRAC ON THE NODE ADDRESS
INITIAL_DEPOSIT_AMOUNT=0
# YOUR IP ADDRESS
IP_HOST=0

#############################################



check_var(){
    if [ $1 = "0" ]; then
        echo $2
        exit
    fi
}

setup_config(){
    sed -i "s/HOSTNAME/$IP_HOST/g" $HOME/.origintrail_noderc
    sed -i "s/HOLDING_TIME/$HOLDING_TIME/g" $HOME/.origintrail_noderc
    sed -i "s/DH_PRICE_FACTOR/$DH_PRICE_FACTOR/g" $HOME/.origintrail_noderc
    sed -i "s/NODE_PUBLIC/$NODE_PUBLIC/g" $HOME/.origintrail_noderc
    sed -i "s/NODE_PRIVATE_KEY/$NODE_PRIVATE_KEY/g" $HOME/.origintrail_noderc
    sed -i "s/MANAGEMENT_WALLET_PUBLIC/$MANAGEMENT_WALLET_PUBLIC/g" $HOME/.origintrail_noderc
    sed -i "s/INITIAL_DEPOSIT_AMOUNT/$INITIAL_DEPOSIT_AMOUNT/g" $HOME/.origintrail_noderc
}

get_boilerplate_configuration(){
    curl "https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/config/.origintrail_noderc" > $CONFIG_FILE

}


check_vars(){
    check_var $NODE_PUBLIC "Please enter your node public address"
    check_var $NODE_PRIVATE_KEY "Please enter your node private address"
    check_var $MANAGEMENT_WALLET_PUBLIC "Please enter your management wallet public address"
    check_var $INITIAL_DEPOSIT_AMOUNT "Please enter a deposit amount > 0 or deposit XTRAC (5000 / 6000)"
    check_var $IP_HOST "Please enter your server IP address"
}

verify_config_file(){
    if ! jq "." /$HOME/.origintrail_noderc; then
        echo "ERROR IN CONFIGURATION FILE, PLEASE FIX IT"
        exit
    fi
}

init_node_install(){
    mkdir $BACKUP_FOLDER
    echo
    echo "WAIT TO SEE YOUR NODE ON THE NETWORK....DO NOT EXIT UNTIL THEN!!!"
    echo
    sudo docker \
        run \
        -i \
        --log-driver json-file \
        --log-opt max-size=1g \
        --name=otnode \
        -p 8900:8900 \
        -p 5278:5278 \
        -p 3000:3000 \
        -v ~/.origintrail_noderc:/ot-node/.origintrail_noderc quay.io/origintrail/otnode:release_mainnet
}


last_check(){
    echo "your holding time: $HOLDING_TIME"
    echo "dh_price factor: $DH_PRICE_FACTOR"
    echo "node public address: $NODE_PUBLIC"
    echo "node private key: $NODE_PRIVATE_KEY"
    echo "management wallet address: $MANAGEMENT_WALLET_PUBLIC"
    echo "initial deposit amount: $INITIAL_DEPOSIT_AMOUNT"
    verify_config_file
    read -p "Are you sure? " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
        then
        exit 1
    fi
}

check_vars
get_boilerplate_configuration
setup_config
verify_config_file
last_check
init_node_install
echo "DONE"
