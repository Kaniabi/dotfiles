for i in tier1 tier3 polestar unhaggle bp pi; do
  case $i in
    bp) REPO_NAME=buildandprice ;;
    pi) REPO_NAME=paymentinsights ;;
    *) REPO_NAME=$i ;;
  esac
  export ${i:u}_REPO=$HOME/autosync/apps/$REPO_NAME
  export ${i:u}_DATA=$HOME/autosync/_data
done
