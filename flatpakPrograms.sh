declare -A mapFlatpak

mapFlatpak["Spotify"]="flatpak install flathub com.spotify.Client -y"
mapFlatpak["RetroArch"]="sudo flatpak install flathub org.libretro.RetroArch -y"
mapFlatpak["Anydesk"]="sudo flatpak install flathub com.anydesk.Anydesk -y"
mapFlatpak["Discord"]="sudo flatpak install flathub com.discordapp.Discord -y"
mapFlatpak["Inkscape"]="sudo flatpak install flathub org.inkscape.Inkscape -y"
mapFlatpak["Remmina"]="sudo flatpak install flathub org.remmina.Remmina -y"
mapFlatpak["Ferdi"]="sudo flatpak install flathub com.getferdi.Ferdi -y"
mapFlatpak["Blender"]="sudo flatpak install flathub org.blender.Blender -y"
mapFlatpak["DBeaver"]="sudo flatpak install flathub io.dbeaver.DBeaverCommunity -y"
mapFlatpak["Insomnia"]="sudo flatpak install flathub rest.insomnia.Insomnia -y"

IFS=" "
read -a arrayNameFlatpak <<< "${!mapFlatpak[@]}"

flatpakLines=()
for name in ${arrayNameFlatpak[@]}
  do
    flatpakLines+=("FALSE" "${name}")
done

# Functions
function appsFlatpak(){
  flatpaks=$(zenity --list --text "Selecione os apps Flatpak que deseja instalar" \
            --checklist --multiple \
            --column "" \
            --column "Nome" \
            ${flatpakLines[@]} ); 

  IFS="|"
  read -a flatpaks <<< "$flatpaks"
  len=${#flatpaks[@]}

  porc=$((90 / $len))
  position=$((1))

  (
  
  echo "# Verificando instalação do flatpak"
  if ! eval flatpak --version
    then
      echo "# Flatpak não instalado"; sleep 1
      # eval "sudo apt install flatpak";
      # Criar func para instalação do flatpak q recebe no param o SO?

  fi

  for i in ${flatpaks[@]}; 
    do 
      echo "$(($porc * $position))" ; sleep 1
      echo "# Instalando $i..." ; sleep 1
      eval ${mapFlatpak[$i]}
      position=$(($position + 1));
  done

  echo "$((100))" ; sleep 1
  echo "# Finalizando..." ; sleep 1

  ) | zenity --progress --auto-close \
  --title="Instalando aplicativos flatpak" \
  --text="Inicializando instalação..." \
  --percentage=0

  # Tratamentos da resposta do dialog;
  if [ "$?" = 1 ] ; then
    zenity --warning --ellipsize --text="Instalação cancelada com sucesso!"
  elif [ "$?" = -1 ] ; then
    zenity --error --ellipsize --text="Erro desconhecido durante a instalação!."
  elif [ "$?" = 0 ] ; then
    zenity --info --ellipsize --text="Aplicativos Flatpak instalados com sucesso!"
  elif [ "$?" = 5 ] ; then
    zenity --error --ellipsize --text="A caixa de diálogo foi fechada porque o tempo limite foi atingido."
  else
    zenity --error --ellipsize --text="Erro desconhecido!"
  fi
  
}