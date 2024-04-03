# WSL specific extras

if ( $IS_WSL ); then
  # INSTALL wslu
  # sudo apt install gnupg2 apt-transport-https
  # wget -O - https://pkg.wslutiliti.es/public.key | sudo gpg -o /usr/share/keyrings/wslu-archive-keyring.pgp --dearmor
  # echo "deb [signed-by=/usr/share/keyrings/wslu-archive-keyring.pgp] https://pkg.wslutiliti.es/debian bookworm main" | sudo tee -a /etc/apt/sources.list.d/wslu.list
  # sudo apt update
  # sudo apt install wslu
fi
