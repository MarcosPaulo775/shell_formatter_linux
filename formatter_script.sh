#!/bin/bash

# Variaveis
DIR= ~/Documentos
# Funcoes
function CriandoPastasPadroes() {
    if [ $(cd $DIR) ]; then
        # Entrando no diretorio
        $(cd $DIR)
        # Criando diretorios
        mkdir Git
        mkdir Livros
        mkdir Workspace
        cd Workspace
        mkdir Python
        mkdir C
        mkdir Java
        mkdir Docker
    fi
}
# Mensagens de boas vindas
echo " ---> Bem vindo ao ambiente de auto-formatação!"
echo " ---> Agora iremos preparar o seu ambiente..."
# Preparação do ambiente
sudo apt-get update -y && CriandoPastasPadroes
sudo apt-get install -y dialog && cmd=(dialog --title 'Instalação Personalizada' --separate-output --checklist "Selecione os programas que deseja instalar:" 00 00 00)
options=(
    1 "Angular, NestJS, NodeJS and Typescript" on
    2 "Blender" off
    3 "Boxy SVG" off
    4 "Docker - (MongoDb and Portainer)" on
    5 "Eclipse" off
    6 "Flameshot" on
    7 "Git" on
    8 "Google Chrome" on
    9 "Insomnia" on
    10 "Open Broadcaster Software(OBS Studio)" off
    11 "Python3 - pip" off
    12 "PWGEN - Gerador de senhas" on
    13 "Robo 3T" on
    14 "Spotify" off
    15 "Sublime Text 3" on
    16 "Ubuntu Restricted Extras" on
    17 "Visual Studio Code" on
    18 "Whatsdesk" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices; do
    case $choice in
    1)
        # Install Curl
        echo -e "\n \033[0;31m ***** install curl ******  \033[0m" &&
            sudo apt install curl -y &&
            echo -e "\n \033[0;32m ***** install curl [OK] ******  \033[0m" &&
            # Install NodeJS
            echo -e "\n \033[0;31m ***** install nodeJS ******  \033[0m" &&
            curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&
            sudo apt install -y nodejs &&
            echo -e "\n \033[0;32m ***** install nodeJS [OK] ******  \033[0m" &&
            # Install Angular
            echo -e "\n \033[0;31m ***** install angular ******  \033[0m" &&
            sudo npm install -g @angular/cli &&
            echo -e "\n \033[0;32m ***** install angular [OK] ******  \033[0m" &&
            # Install NestJS
            echo -e "\n \033[0;31m ***** install nestjs ******  \033[0m" &&
            sudo npm i -g @nestjs/cli &&
            echo -e "\n \033[0;32m ***** install nestjs [OK] ******  \033[0m" &&
            # Install Typescript
            echo -e "\n \033[0;31m ***** install typescript ******  \033[0m" &&
            sudo npm install -g typescript &&
            echo -e "\n \033[0;32m ***** install typescript [OK] ******  \033[0m"
        ;;
    2)
        # Install Blender
        echo -e "\n \033[0;31m ***** install blender ******  \033[0m" &&
            sudo snap install blender --classic &&
            echo -e "\n \033[0;32m ***** install blender [OK] ******  \033[0m"
        ;;
    3)
        # Install Boxy SVG
        echo -e "\n \033[0;31m ***** install boxy svg ******  \033[0m" &&
            sudo snap install boxy-svg &&
            echo -e "\n \033[0;32m ***** install boxy svg [OK] ******  \033[0m"
        ;;
    4)
        # Install Docker
        echo -e "\n \033[0;31m ***** install docker ******  \033[0m" &&
            sudo snap install docker &&
            echo -e "\n \033[0;32m ***** install docker [OK] ******  \033[0m" &&
            # Download Portainer
            echo -e "\n \033[0;31m ***** download portainer ******  \033[0m" &&
            sudo docker pull portainer/portainer &&
            echo -e "\n \033[0;32m ***** download portainer [OK] ******  \033[0m" &&
            # Install Portainer
            echo -e "\n \033[0;31m ***** install portainer ******  \033[0m" &&
            sudo docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v ~/Portainer/data:/data portainer/portainer &&
            echo -e "\n \033[0;32m ***** install portainer [OK] ******  \033[0m" &&
            # Download MongoDB
            echo -e "\n \033[0;31m ***** download mongo ******  \033[0m" &&
            sudo docker pull mongo &&
            echo -e "\n \033[0;32m ***** download mongo [OK] ******  \033[0m" &&
            # Install MongoDB
            echo -e "\n \033[0;31m ***** install mongo ******  \033[0m" &&
            sudo docker run -d -p 27017:27017 -p 28017:28017 --restart always --name mongo mongo &&
            echo -e "\n \033[0;32m ***** install mongo [OK] ******  \033[0m" &&
            # Install MongoDB Tools
            echo -e "\n \033[0;31m ***** install mongo-tools ******  \033[0m" &&
            sudo apt install mongo-tools -y
        echo -e "\n \033[0;32m ***** install mongo-tools [OK] ******  \033[0m"
        ;;
    5)
        # Install Eclipse
        echo -e "\n \033[0;31m ***** install eclipse ******  \033[0m" &&
            sudo snap install eclipse --classic &&
            echo -e "\n \033[0;32m ***** install eclipse [OK] ******  \033[0m"
        ;;
    6)
        # Install Flameshot
        echo -e "\n \033[0;31m ***** install flameshot ******  \033[0m" &&
            sudo apt install flameshot -y &&
            echo -e "\n \033[0;32m ***** install flameshot [OK] ******  \033[0m"
        ;;
    7)
        # Install Git
        echo -e "\n \033[0;31m ***** install git ******  \033[0m" &&
            sudo apt install git -y &&
            echo -e "\n \033[0;32m ***** install git [OK] ******  \033[0m" &&
            # Config Git
            echo -e "\n \033[0;31m ***** config git and bashrc ******  \033[0m" &&
            git config --global credential.helper 'cache --timeout=28800' &&
            git config --global core.editor "code --wait" &&
            echo "export PS1='\[\033[1;32m\]\u@\[\033[1;32m\]\h\[\033[1;32m\]: \[\033[1;34m\]\w\[\033[0;36m\]\$(__git_ps1 \" (%s)\")\[\033[0m\]$ '" >>~/.bashrc
        echo -e "\n \033[0;32m ***** config git and bashrc [OK]******  \033[0m"
        ;;
    8)
        # Install wget
        echo -e "\n \033[0;31m ***** install wget ******  \033[0m" &&
            sudo apt install wget -y &&
            echo -e "\n \033[0;32m ***** install wget [OK] ******  \033[0m" &&
            # Download Chrome
            echo -e "\n \033[0;31m ***** download chrome ******  \033[0m" &&
            wget -r https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/chrome.deb &&
            echo -e "\n \033[0;32m ***** download chrome [OK] ******  \033[0m" &&
            # Install Chrome
            echo -e "\n \033[0;31m ***** install chrome ******  \033[0m" &&
            sudo dpkg -i ~/chrome.deb &&
            echo -e "\n \033[0;32m ***** install chrome [OK] ******  \033[0m"
        ;;
    9)
        # Install Insomnia
        echo -e "\n \033[0;31m ***** install insomnia ******  \033[0m" &&
            sudo snap install insomnia &&
            echo -e "\n \033[0;32m ***** install insomnia [OK] ******  \033[0m"
        ;;
    10)
        # Install OBS-Studio
        echo -e "\n \033[0;31m ***** install obs-studio ******  \033[0m" &&
            sudo snap install obs-studio &&
            echo -e "\n \033[0;32m ***** install obs-studio [OK] ******  \033[0m"
        ;;
    11)
        # Install Python3 - pip
        echo -e "\n \033[0;31m ***** install python3-pip ******  \033[0m" &&
            sudo apt install python3-pip -y &&
            echo -e "\n \033[0;32m ***** install python3-pip [OK] ******  \033[0m"
        ;;
    12)
        # Install pwgen
        echo -e "\n \033[0;31m ***** install pwgen ******  \033[0m" &&
            sudo apt install pwgen -y &&
            echo -e "\n \033[0;32m ***** install pwgen [OK] ******  \033[0m"
        ;;
    13)
        # Install Robo 3T
        echo -e "\n \033[0;31m ***** install robo3t ******  \033[0m" &&
            sudo snap install robo3t-snap &&
            echo -e "\n \033[0;32m ***** install robo3t [OK] ******  \033[0m"
        ;;
    14)
        # Install Spotify
        echo -e "\n \033[0;31m ***** install spotify ******  \033[0m" &&
            sudo snap install spotify &&
            echo -e "\n \033[0;32m ***** install spotify [OK] ******  \033[0m"
        ;;
    15)
        # Install Sublime
        echo -e "\n \033[0;31m ***** install sublime-text ******  \033[0m" &&
            sudo snap install sublime-text --classic &&
            echo -e "\n \033[0;32m ***** install sublime-text [OK] ******  \033[0m"
        ;;
    16)
        # Install Ubuntu Extras
        echo -e "\n \033[0;31m ***** install ubuntu-restricted-extras ******  \033[0m" &&
            sudo apt install ubuntu-restricted-extras -y
        echo -e "\n \033[0;32m ***** install ubuntu-restricted-extras [OK] ******  \033[0m"
        ;;
    17)
        # Install VSCode
        echo -e "\n \033[0;31m ***** install visual studio code ******  \033[0m" &&
            sudo snap install code --classic &&
            echo -e "\n \033[0;32m ***** visual studio code [OK] ******  \033[0m"
        ;;
    18)
        # Install Whatsdesk
        echo -e "\n \033[0;31m ***** install whatsdesk ******  \033[0m" &&
            sudo snap install whatsdesk &&
            echo -e "\n \033[0;32m ***** install whatsdesk [OK] ******  \033[0m"
        ;;
    esac
done
