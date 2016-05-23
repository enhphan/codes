#!/bin/bash
#this script is to be ran on a per-simulation basis to collect the 
#CNC from the PDB file at each step
#To prevent modification of the original output pdb files, we'll
#make a working copy of all the pdbs
mkdir $PWD/temp #temporary copy
mkdir $PWD/temp/cncco #output of the coordinate pull
for n in x.pdb_*
	do cp $n ./temp
done
echo "duplication finished"
cd ./temp
#rename 's/\d+/sprintf("%5d",$&)/e' x.pdb_* #pad the numbering with zeros as needed
#echo "renaming finished"
#the next block takes all the copied pdb from temp, look for the C1', N1, and C2 entries for each of the nucleotide and write the line with their coordinates out to a file in cncco numbered to match the pdb without padding
for f in x.pdb_0* 
	do
	awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
	done
echo "cycle 0 finished"
for f in x.pdb_1* 
        do
        awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
        done
echo "cycle 1 finished"
for f in x.pdb_2* 
        do
        awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
        done
echo "cycle 2 finished"
for f in x.pdb_3* 
        do
        awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
        done
echo "cycle 3 finished"
for f in x.pdb_4* 
        do
        awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
        done
echo "cycle 4 finished"
for f in x.pdb_5* 
        do
        awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
        done
echo "cycle 5 finished"
for f in x.pdb_6* 
        do
        awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
        done
echo "cycle 6 finished"
for f in x.pdb_7* 
        do
        awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
        done
echo "cycle 7 finished"
for f in x.pdb_8* 
        do
        awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
        done
echo "cycle 8 finished"
for f in x.pdb_9* 
        do
        awk '/(C1'\''|N1|C2[^2'\''])/{ print $0 }' < $f > $PWD/cncco/$f
        done
echo "cycle 9 finished"
cd cncco
rename 's/(.{6})(.*)$/$2/' *.*
echo "renaming finished"
cd ..
cd ..
mv $PWD/temp/cncco $PWD/cncco
rm -R temp
echo "cleaned up"
#rm -R temp #cleaning up the temporary copies
