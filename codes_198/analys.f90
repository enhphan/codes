program analysis
!
!
implicit none
character(len=30)::file1(10001,1)
real*8::coord(3,3,24),hit(24,24,10001)
open(unit=1, file='filename')
open(unit=2, file='test_in')
open(unit=3, file='test_coord')
100 format(A30)
101 format(F6.3xF7.3,xF7.3)
!
!
read(1,100) file1 !read in file name from generated by cncgen.sh
write(2,100)file1 !TEST: write out the filenames read in from cncgen.sh. Comment out
!
!Loop over the all of the different files to read in their coordinates starts here.
!comment out the loop to read in a single file for testing purposes.
!
!
do n=1,10001 ! index of entries in file1; gives the file name
 open(unit=13, file=file1(10001,1))
 read(13,101) coord
 !
 !the line below writes out the collection of coordinates for double checking
 !commentout as needed.
 write(3,101) coord(1,1,2),coord(2,1,2),coord(3,1,2)
do m=1,23 !loop over the coordinates of the 24 residue in the polyuracil pairwise
 do l=m,24 !
Placeholder for result of GETBOND.F
   if !check if the two residue are close enough together
   then !place holder for result of GETBANG.F
     if ! check if the two residue forms the correct cnc bond angle
      then !place holder for result of torsion angle
       if !check the tosion angles is sufficiently small
        then hit(l,m,n)=1 !final check for torsion angle
       else hit(l,m,n)=0
     else hit(l,m,n)=0 !exit condition for bond angle
   else hit(l,m,n)=0 !exit condition for bond length
  end if !end of if loop for a given m,n pair
end do!end the loop over l, the second residue of the pairing
end do! end loop over m, the first residue of the pairing
end do ! end loop over n, the index of the pdb output.
stop 
end
