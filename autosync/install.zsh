export AUTOSYNC_DIR=$HOME/autosync

if [[ -d $AUTOSYNC_DIR ]]; then
  for i in tier1 tier3 polestar unhaggle bp pi peb; do
    case $i in
      bp) REPO_NAME=buildandprice ;;
      pi) REPO_NAME=paymentinsights ;;
      *) REPO_NAME=$i ;;
    esac
    export ${i:u}_REPO=$AUTOSYNC_DIR/apps/$REPO_NAME
    export ${i:u}_DATA=$AUTOSYNC_DIR/_data
  done
  for i in uh_core moto_core uh_status uh_inventory tierless; do
    REPO_NAME=$i
    export ${i:u}_REPO=$AUTOSYNC_DIR/libs/$REPO_NAME
    export ${i:u}_DATA=$AUTOSYNC_DIR/_data
  done

  export CAWS_REPO=$AUTOSYNC_DIR/apps/credit-app
  export CONTAINER_UID=$(id -u)
fi