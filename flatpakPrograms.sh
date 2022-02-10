declare -A mapFlatpak


mapFlatpak["Anydesk"]="flatpak install flathub com.anydesk.Anydesk -y"
mapFlatpak["Blanket"]="flatpak install flathub com.rafaelmardojai.Blanket -y"
mapFlatpak["Blender"]="flatpak install flathub org.blender.Blender -y"
mapFlatpak["ColorPicker"]="flatpak install flathub nl.hjdskes.gcolor3 -y"
mapFlatpak["DBeaverCommunity"]="flatpak install flathub io.dbeaver.DBeaverCommunity -y"
mapFlatpak["Darktable"]="flatpak install flathub org.darktable.Darktable -y"
mapFlatpak["Discord"]="flatpak install flathub com.discordapp.Discord -y"
mapFlatpak["ExtensionManager"]="flatpak install flathub com.mattjakeman.ExtensionManager -y"
mapFlatpak["Ferdi"]="flatpak install flathub com.getferdi.Ferdi -y"
mapFlatpak["Figma"]="flatpak install flathub io.github.Figma_Linux.figma_linux -y"
mapFlatpak["Filezilla"]="flatpak install flathub org.filezillaproject.Filezilla -y"
mapFlatpak["Flameshot"]="flatpak install flathub org.flameshot.Flameshot -y"
mapFlatpak["GIMP"]="flatpak install flathub org.gimp.GIMP -y"
mapFlatpak["GIMPMANUAL"]="flatpak install flathub org.gimp.GIMP.Manual -y"
mapFlatpak["Glimpse"]="flatpak install flathub org.glimpse_editor.Glimpse -y"
mapFlatpak["GravitDesigner"]="flatpak install flathub io.designer.GravitDesigner -y"
mapFlatpak["GtkStressTesting"]="flatpak install flathub com.leinardi.gst -y"
mapFlatpak["Inkscape"]="flatpak install flathub org.inkscape.Inkscape -y"
mapFlatpak["Insomnia"]="flatpak install flathub rest.insomnia.Insomnia -y"
mapFlatpak["Krita"]="flatpak install flathub org.kde.krita -y"
mapFlatpak["OBSStudio"]="flatpak install flathub com.obsproject.Studio -y"
mapFlatpak["ONLYOFFICE"]="flatpak install flathub org.onlyoffice.desktopeditors -y"
mapFlatpak["Peek"]="flatpak install flathub com.uploadedlobster.peek -y"
mapFlatpak["Remmina"]="flatpak install flathub org.remmina.Remmina -y"
mapFlatpak["RetroArch"]="flatpak install flathub org.libretro.RetroArch -y"
mapFlatpak["Scribus"]="flatpak install flathub net.scribus.Scribus -y"
mapFlatpak["Shotcut"]="flatpak install flathub org.shotcut.Shotcut -y"
mapFlatpak["SpaceCadetPinball"]="flatpak install flathub com.github.k4zmu2a.spacecadetpinball -y"
mapFlatpak["Spotify"]="flatpak install flathub com.spotify.Client -y"
mapFlatpak["Steam"]="flatpak install flathub com.valvesoftware.Steam -y"
mapFlatpak["VLC"]="flatpak install flathub org.videolan.VLC -y"
mapFlatpak["VideoDownloader"]="flatpak install flathub com.github.unrud.VideoDownloader -y"

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