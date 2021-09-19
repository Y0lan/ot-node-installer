#!/bin/sh


generateRandomSalt(){
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
} 

changeAccountToUser(){
    su - "user-$(hostname)" 
}


checkEnvVariable(){
    if [ -z "$USERPASSWORD" ]; then
        echo "please do export USERPASSWORD=<yourpasswordhere>"
        exit 1
    fi
}

installDocker(){
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
        apt update
        apt-cache policy docker-ce
        apt install -y docker-ce
        usermod -aG docker "user-$(hostname)"
        systemctl start docker
        systemctl enable docker
}

addSwap(){
    message "ADDING 4GB OF SWAP"
    fallocate -l 4G /swap
    chmod 600 /swap
    mkswap /swap
    swapon /swap
    cp /etc/fstab /etc/fstab.bak
    echo '/swap none swap sw 0 0' | sudo tee -a /etc/fstab
    free
    finish
}

installBasicSoftware(){
    message "UPDATING THE SYSTEM AND INSTALLING ESSENTIALS SOFTWARES FOR THE NODE"
    apt update && apt upgrade -y
    apt install -y \
    build-essential \
    software-properties-common \
    git \
    bash \
    zip \
    wget \
    zsh \
    vim \
    ufw \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    fail2ban \
    openssl \
    gnupg \
    npm \
    nodejs \
    unattended-upgrades \
    jq

    npm install gtop -g
    systemctl enable unattended-upgrades
    systemctl start unattended-upgrades

    curl https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/config/50unattended-upgrades > /etc/apt/apt.conf.d/50unattended-upgrades
    curl https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/config/20auto-upgrades > /etc/apt/apt.conf.d/20auto-upgrades




    curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
    wget -qO- https://repos-droplet.digitalocean.com/install.sh | sudo bash

    installDocker
    
    finish
}

setupFail2Ban(){
    message "SETTING UP FAIL2BAN SECURITY"
    systemctl start fail2ban
    systemctl enable fail2ban
    curl https://raw.githubusercontent.com/Y0lan/ot-node-installer/main/config/jail.local > /etc/fail2ban/jail.local
    systemctl restart fail2ban
    finish
}

setupZSH(){
    username="user-$(hostname)"
    message "ADDING ZSH AS DEFAULT SHELL FOR $username"
    chsh -s $(which zsh) "$username"
    touch /home/$username/.zshrc
    finish
}


message(){
    echo
    echo
    echo "#############"
    echo "$1"
    echo "#############"
    echo
    echo
    
}

finish(){
    echo
    echo "DONE"
}

setupServer(){
    installBasicSoftware
    createUser
    disableRootLogin
    addSwap 
    setupZSH
    setupFirewall
    setupFail2Ban
    unattended-upgrades --dry-run --debug
}

setupFirewall(){

    message "ENABLE FIREWALL AND OPEN SSH AND NODE PORT"
    ufw allow OpenSSH
    ufw allow 8900
    ufw allow 5278
    ufw allow 3000
    ufw allow 22/tcp
    ufw show added
    yes | ufw enable
    ufw status
    finish
}

addSudoTo(){
    usermod -aG sudo "$1"
}

createUser(){
    username="user-$(hostname)"
    message "CREATING USER $username"
    adduser --disabled-password --gecos "" "$username" 
    finish

    message "ADDING USER $username TO SUDO"
    addSudoTo "$username" 
    finish

    message "ALLOWING SSH CONNECTION FOR $username"
    cp -r ~/.ssh /home/"$username" 
    chown -R "$username:$username" /home/"$username"/.ssh 
    finish

    message "ADDING SUDO PASSWORD $USERPASSWORD TO $username"
    usermod -p $(openssl passwd -1 -salt $(generateRandomSalt) "$USERPASSWORD") "$username"
    finish

    
}

disableRootLogin(){
    message "DISABLING ROOT LOGIN"
    sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
    finish
}

checkEnvVariable
message "OT-NODE-INSTALLER V1.0"
echo "IT WILL TAKE SOME TIME, HANG OUT..."
setupServer
changeAccountToUser



