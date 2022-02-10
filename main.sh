#!/bin/bash
source flatpakPrograms.sh
source snapPrograms.sh

# Variáveis
packageType='';


# Selecionando packageType
packageType=$(zenity  --list  --text "Selecione o tipo de aplicativos que deseja instalar" \
    --radiolist \
    --column "" \
    --column "Sistemas" \
    TRUE Flatpak FALSE Snap);

if [ $packageType == "Flatpak" ];
then
    appsFlatpak
elif [ $packageType == "Snap" ]
then
    appsSnap
else
    echo "Cancelado com sucesso!"
fi

