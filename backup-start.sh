#!/bin/bash

BACKUP_FOLDER=$HOME/backup


backup_node_identity_and_id(){
    mkdir -p $BACKUP_FOLDER
    # IDENTITY
    sudo docker cp otnode:/ot-node/data/xdai_erc725_identity.json $BACKUP_FOLDER/xdai_erc725_identity.json
    # ID
    sudo docker cp otnode:/ot-node/data/identity.json $BACKUP_FOLDER/identity.json

    # ENCRYPT IT
    zip -r -e $HOME/backup.zip $BACKUP_FOLDER
}


finish_node_config(){
    sudo docker restart otnode
    sudo docker update --restart=always otnode
    sudo docker logs -f otnode
}

start_node(){
    sudo docker start otnode
    sudo docker logs otnode -f
}

backup_node_identity_and_id
finish_node_config
start_node


