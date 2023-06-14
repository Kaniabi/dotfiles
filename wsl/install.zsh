export BROWSER="INVALID"
declare -a BROWSERS=(
  "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
  "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
)
for i_browser in $BROWSERS; do
  if [[ -f "$i_browser" ]]; then
    export BROWSER=$i_browser
    break
  fi
done
