if [ -f "./quizzee.dst" ]; then
  if [[ "$1" = "--shuffle" ]]; then
    shuf quizzee.dst > quizzee-shuf.dst
    rm quizzee.dst
    mv quizzee-shuf.dst quizzee.dst
  elif [ -z "$1" ]; then
    :
  else
    echo Unknown argument.
  fi
  lines=$(wc -l quizzee.dst | awk '{print $1}')
  for ((i=1; i<=lines; i++)); do
    term=$(cat quizzee.dst | head -n$i | tail -n1 | sed 's/\ :.*//')
    defi=$(cat quizzee.dst | head -n$i | tail -n1 | sed 's/.*:\ //')
    printf "$term: "
    read userdef
    if [[ "$userdef" == "$defi" ]]; then
      echo Correct!
    else
      echo Wrong: $defi
    fi
  done
else
  echo No quizzee.dst file.
fi
