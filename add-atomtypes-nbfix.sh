#!/bin/bash

f=$1
mv $f $f-orig

awk 'BEGIN{a=0; n=0}
     (/^\[/ || /^$/) && a{print "\
  Dz   20    28.08    0.0000  A       0.2818     3.62\n\
  Da    1    2.0      0.0000  A       0.0095     2.2"; a=0}
     (/^\[/ || /^$/) && n{print "\n\
#include \"nbfix_cam.itp\""; n=0}
     /^\[ *atomtypes *\]/{a=1}
     /^\[ *nonbond_params *\]/{n=1}
  1' $f-orig > $f
