#!/bin/bash
source flatpakPrograms.sh

# Variáveis
SO='';


# Selecionando SO
SO=$(zenity  --list  --text "Selecione o seu sistema" \
    --radiolist \
    --column "" \
    --column "Sistemas" \
    TRUE Ubuntu FALSE Fedora);

if [ $SO == "Ubuntu" ];
then
    appsFlatpak
elif [ $SO == "Fedora" ]
then
    appsFlatpak
else
    echo "Cancelado com sucesso!"
fi

