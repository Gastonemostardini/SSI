#!/usr/bin/env bash
# Conta le parole (testo, esclusi titoli e commenti) dei .tex dentro sec/
# per ogni cartella di SSI che ha una sottocartella sec/.
# Uso: ./conta_parole.sh            -> tutte le cartelle
#      ./conta_parole.sh OSINT      -> solo quella cartella
cd "$(dirname "$0")"
dirs=("$@"); [ ${#dirs[@]} -eq 0 ] && dirs=(*/)
for d in "${dirs[@]}"; do
  d=${d%/}; [ -d "$d/sec" ] || continue
  echo "== $d =="
  tot=0
  for f in "$d"/sec/*.tex; do
    [ -e "$f" ] || continue
    n=$(texcount -1 -utf8 -q "$f" 2>/dev/null | grep -oE "^[0-9]+" | tail -1); n=${n:-0}
    printf '%6d  %s\n' "$n" "$(basename "$f" .tex)"
    tot=$((tot + n))
  done
  echo "------"
  printf '%6d  TOTALE\n\n' "$tot"
done
