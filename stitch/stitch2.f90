program stitching
!
!
!
!DICTATE THE FRAGMENTS THAT YOU WANTED STITCHED TOGETHER USING THE ABSOLUTE PATH
!OF THEIR RXP FILES. TO ALLOW AN ARBITRARY STRUCTURE TO BE STITCHED TOGETHER, 
!WE'LL READ IN THE LIST OF THE FRAGMENTS' ABSOLUTE PATHS IN THE ORDER THAT THEY 
!ARE TO BE STITCHED IN. THE PATHS SHOULD BE IN A FILE CALLED 'fragments.in'
implicit none
character(len=180)::rxpline,fragpath,testline
real*8::
integer::io1,io2,io3
open(unit=10, file='fragments.in')
open(unit=11, file='working.rxp')
100 format(A180)
do
 read(10,100,iostat=io)fragpath !read in the absolute path in fragments.in
  if(io1 /= 0) then
  write(*,*) "Something went wrong. Check to make sure that your fragments.in is properly set up."
  exit
  else if (io1 == 0) then !loop to open and read in the lines of the rxp file
   open(unit=12, file=fragpath)
   do
    read(12,100,iostat=io2)testline !read in the rxp file line by line
    if (io2 ==0) then
     write(11,100)testline !write out the lines to working.rxp
     rxpline=testline
    else 
     rxpline(33:40)='-9.9999'!write non-sense Xi on last line of fragment's rxp
     write(11,100))rxpline !write the modded line to working file
     exit
    endif
   enddo
  endif
enddo 
!______________________________________________________________________________
!
!The next block of code scans through the line of concatenated rxp and writes it 
!out to a clean x.rxp which can be used with nucleic exe to generate the pdb. 
!Note that the "non-sense" flag will lead to the replacement of the nonsense 
!Xi with a "useful" Xi and the insertion of an additional line which stitches 
!together the last residue of one fragment with the first residue of the next one
!and officially replaces the fake residue that preceeds and ends each fragment
!
open(unit=14,x.rxp)
do
read(13,100,iostat=io3)rxpline
 if(io3 == 0) then
  if (rxpline(33:40) == "-9.9999") then 
   rxpline(33:40) = ''!replaces the placeholder Xi with the desired value
   write(13,100)rxpline !write out the rxpline we just read in with new values
   rxpline(1:8) !R INCOMPLETE
   rxpline(9:16) !E INCOMPLETE
   rxpline(17:24) !T INCOMPLETE
   rxpline(25:32) !O INCOMPLETE
   rxpline(33:40) !X INCOMPLETE
   rxpline(41:48) !PhiL INCOMPLETE
   rxpline(49:56) !PhiR INCOMPLETE
   write(13,100)rxpline !write out the bridging line
  else 
   write(13,100)rxpline !if no non-sense flag, write the line normally
  endif
 else 
 exit
 endif
enddo
stop
end
