# Multisite_Calcium
A multisite calcium ion model optimized for calcium-protein interactions in molecular dynamics simulations

Usage of the Multi-site Ca++ (CAM) Model for Molecular Dynamics Simulations:

This model was developed by the Song Group at Peking University.

20190418 by Chunhong Liu

20210129 by Aihua Zhang

If the model is used in your work, please cite the following paper:
Zhang, A., Yu, H., Liu, C. et al. The Ca2+ permeation mechanism of the ryanodine 
receptor revealed by a multi-site ion model. Nat Commun 11, 922 (2020). 
https://doi.org/10.1038/s41467-020-14573-w

The model should be used with the *CHARMM FORCE FIELD* and 
*TIPS3P WATER MODEL*.

**Please test the model very carefully in your simulation system before extensive usage.**

1. Introduction to the CAM Model

The multi-site calcium (CAM) model represents a divalent calcium cation by an
effective ``molecule'' with seven conventional electrostatic and LJ interaction
sites, which are classified into two atomtypes, i.e. Dz and Da. The central atom
(D0) has the Dz atomtype, while six coordinating atoms (D1-D6), locating at the
vertices of an octahedral, has the Da atomtype. The CAM parameters were 
optimized by its binding energies with proteins and properties in water. The
optimization was performed against the *TIPS3P water model* and protein 
parameters from the *CHARMM force field*, which should be always used together 
with the CAM model. 
Please refer to this paper (https://doi.org/10.1038/s41467-020-14573-w)
for more details.

2. Files

The CAM parameters are provided in two GROMACS *.itp files under the cam-itps
directory:
(1) cam.itp, which defines two atomtypes (Dz and Da) and the CAM molecule. Note
that LJ parameters of Dz in cam.itp are those for protein interactions.
(2) nbfix_cam.itp, which refines the LJ interaction between Dz and water (OT and
HT).

3. Usage of the CAM Model

Here we will give a step-by-step example of preparation an MD simulation using
the CAM model starting with configuration files generated by CHARMM-GUI for
GROMACS. The shell command for each step is prefixed with CMD.

Step 1. copy CAM files to the topology parameter directory (toppar/ in this example).\
CMD: cp cam-itps/cam.itp cam-itps/nbfix_cam.itp toppar/

Step 2. add declaration of Dz and Da atomtypes and include nbfix_cam.itp in
 the forcefield topology file. (toppar/charmm36.itp in this example)
CMD: ./add-atomtypes-nbfix.sh toppar/charmm36.itp

Step 3. replace calcium cations (CAL) with CAM in system.gro structure file.
CMDS: ./put-octahedral-cam-to-gro.pl 0.0905 system.gro > system_cam.gro

Step 4. manually edit topol.top.
(1) add a line of ``#include "toppar/cam.itp"'' below
``#include "toppar/charmm36.itp"''
(2) change CAL to CAM

Step 5. Generate tpr for gromacs simulation.
CMD: gmx grompp -f md.mdp -c system_cam.gro -p topol.top -o system.tpr -maxwarn 2
Two warnings of atomtype overwriting due to definitions of Dz and Da in
charmm36.itp and cam.itp are harmless.
