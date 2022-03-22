for i in tier1 tier3 polestar unhaggle buildandprice paymentinsights; do
  export ${i:u}_REPO=$HOME/autosync/apps/$i
  export ${i:u}_DATA=$HOME/autosync/_data
done
