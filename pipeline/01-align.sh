#!/bin/bash

cat .input | grep -v {{reference}} | grep -v template | sed "s/.pdb//g" | xargs -P 8 -I % USalign -mm 1 -ter 1 -outfmt 2  %.pdb '{{reference}}' -o %.aligned >> {{product['tmscore']}}
rm *.aligned*pml
ls *.aligned.pdb > {{product['list']}}