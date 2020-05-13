#!/bin/env zsh

set -e

ag --py -l "Decimal\(" | xargs /d/Projects/dotfiles/bin/decimal_constant.py
ag --py -l -s "DECIMAL_ZERO" | xargs isort -y -a "from uh_core.decimals import DECIMAL_ZERO"
ag --py -l -s "DECIMAL_ZERO" | xargs autoflake -i --remove-all-unused-imports

sed -i "s/uh-core==.*/uh-core==3.1.0b650.dev1/g" require*.in
sed -i "s/uh-inventory==.*/uh-inventory==2.1.3b650.dev1/g" require*.in

if [[ -n $1 ]]
then
  ddr $1-py2 update-requirements
  ddr $1-py3 update-requirements
fi
