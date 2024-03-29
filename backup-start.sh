#!/bin/bash

BACKUP_FOLDER=$HOME/backup


backup_node_identity_and_id(){
    mkdir -p $BACKUP_FOLDER
    # IDENTITY
    sudo docker cp otnode:/ot-node/data/xdai_erc725_identity.json $BACKUP_FOLDER/xdai_erc725_identity.json
    # ID
    sudo docker cp otnode:/ot-node/data/identity.json $BACKUP_FOLDER/identity.json

    # ENCRYPT IT
    echo "ENCRYPTING YOUR NODES IDENTITY (TO GET BACK YOUR MONEY IN CASE YOUR SERVER CRASH)"
    echo "ENTER A PASSWORD FOR THE BACKUP.ZIP FILE: "
    zip -r -e $HOME/backup.zip $BACKUP_FOLDER
    ls -l $BACKUP_FOLDER/
}


finish_node_config(){
    echo "RESTARTING NODE"
    sudo docker restart otnode
    sudo docker update --restart=always otnode
}

start_node(){
    sudo docker start otnode
    sudo docker ps
    sudo docker logs otnode -f
}

backup_node_identity_and_id
finish_node_config
start_node


