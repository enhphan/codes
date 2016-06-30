program stitching
!
!We'll be borrowing a lot of the modules used for the Nucleic program. To that
!we will be piggy backing off of Chi's make file for the nucleic program so I 
!wont have to map out all of the dependencies. The part we really care about is
!the backbone entropy calculation and whether or not the backbone closes.
!A copy of the stitch?.f90 source code will have to be cp into the source code
!of nucleic for compilation.
!
!
!DICTATE THE FRAGMENTS THAT YOU WANTED STITCHED TOGETHER USING THE ABSOLUTE PATH
!OF THEIR RXP FILES. TO ALLOW AN ARBITRARY STRUCTURE TO BE STITCHED TOGETHER, 
!WE'LL READ IN THE LIST OF THE FRAGMENTS' ABSOLUTE PATHS IN THE ORDER THAT THEY 
!ARE TO BE STITCHED IN. THE PATHS SHOULD BE IN A FILE CALLED 'fragments.in'
!
!
!implicit none
character(len=180)::fragpath
integer::io1
logical::header=.true.
open(unit=10, file='fragments.in')
open(unit=11, file='stitched.rxp')
100 format(A180)

character(len=180)::join(5),testline,1b4,2b4
integer::io2
logical::first

!______________________________________________________________________________

!begin reading filepath of fragment and opening them
do
1000 read(10,100,iostat=io1)fragpath !read in the absolute path in fragments.in
  if(io1 /= 0) then !exit if EoF or read error occurs with the fragments.in
  write(*,*) "Something went wrong. Check to make sure that your fragments.in is properly set up."
  exit


!loop to open and read in the lines of the rxp file
  else if (io1 == 0) then 
   open(unit=12, file=fragpath)


!The header does not have a call to the backbone calculation and contributes only the first 2 elements to the join(5)
   if (header=.true.)!The header file does not have a call to the backbone calculation
   first=.true.
   do
    read(12,100,iostat=io2)testline !read in the rxp file line by line
    if (io2 ==0) then
     write(11,100)testline !write out the lines to the final rxp file
      if(first==.true.) then
       1b4=testline
       first=.false.
      else
       2b4=1b4
       1b4=testline
      endif
    else !when you hit the end of the file
     join(1)=2b4
     join(2)=1b4 !this line has the gibberish chi value
     join(3)=0 !this line will become the joining line
     close(12)
    endif
   enddo
   header=.false.!changes marks that everything else is a not the first fragment file
   go to 1000!return to the top of the do loop and read in the next fragment's path 
!______________________________________________________________________________
!
!The next block of code applies to all fragments that are not the first fragment. we open and read in the first
!two lines into the the last two elements of join(5). join(5) is then modified: written out to an rxp file and  
stop
end
