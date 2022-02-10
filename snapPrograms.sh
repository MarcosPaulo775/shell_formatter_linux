declare -A mapSnap


mapSnap["AndroidStudio"]="snap install android-studio"
mapSnap["BeekeeperStudio"]="snap install beekeeper-studio"
mapSnap["ConverterNOW"]="snap install converternow"
mapSnap["Emote"]="snap install emote"
mapSnap["FlutterSDK"]="snap install flutter"
mapSnap["Robo3t"]="snap install robo3t-snap"
mapSnap["VisualStudioCode"]="snap install code --classic"


IFS=" "
read -a arrayNameSnap <<< "${!mapSnap[@]}"

snapLines=()
for name in ${arrayNameSnap[@]}
  do
    snapLines+=("FALSE" "${name}")
done

# Functions
function appsSnap(){
  snaps=$(zenity --list --text "Selecione os apps Snap que deseja instalar" \
            --checklist --multiple \
            --column "" \
            --column "Nome" \
            ${snapLines[@]} ); 

  IFS="|"
  read -a snaps <<< "$snaps"
  len=${#snaps[@]}

  porc=$((90 / $len))
  position=$((1))

  (
  for i in ${snaps[@]}; 
    do 
      echo "$(($porc * $position))" ; sleep 1
      echo "# Instalando $i..." ; sleep 1
      eval ${mapSnap[$i]}
      position=$(($position + 1));
  done

  echo "$((100))" ; sleep 1
  echo "# Finalizando..." ; sleep 1

  ) | zenity --progress --auto-close \
  --title="Instalando aplicativos snap" \
  --text="Inicializando instalação..." \
  --percentage=0

  resp=$?
  # Tratamentos da resposta do dialog;
  if [ $resp = 1 ]; then
    zenity --warning --ellipsize --text="Instalação cancelada com sucesso!"
  elif [ $resp = -1 ]; then
    zenity --error --ellipsize --text="Erro desconhecido durante a instalação!."
  elif [ $resp = 0 ]; then
    zenity --info --ellipsize --text="Aplicativos Snap instalados com sucesso!"
  elif [ $resp = 5 ]; then
    zenity --error --ellipsize --text="A caixa de diálogo foi fechada porque o tempo limite foi atingido."
  else
    zenity --error --ellipsize --text="Erro desconhecido!"
  fi
  
}