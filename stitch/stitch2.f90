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
    implicit none
      character(len=180)::fragpath
      integer::io1
      logical::header=.true.
      open(unit=10, file='fragments.in')
      open(unit=11, file='stitched.rxp')
100   format(A180)

      character(len=180)::join(5),testline,b4,twob4
      integer::io2
      logical::first,second,third
!     unit=12, file=fragpath ; currently being used in the loop structure
       
!     
!______________________________________________________________________________

!begin reading filepath of fragment and opening them
      do
1000    read(10,100,iostat=io1)fragpath !read in the absolute path in fragments.in
        if(io1 /= 0) then !exit if EoF or read error occurs with the fragments.in
          write(*,*) "Something went wrong. Check to make sure that your fragments.in is properly set up."
          exit
        else if (io1 == 0) then !loop to open and read in the lines of the rxp file
          open(unit=12, file=fragpath)
          if (header=.true.) then!The header doesn't have a call to the backbone calculation
            first=.true.
            do
              read(12,100,iostat=io2)testline !read in the rxp file line by line
              if (io2 ==0) then
                write(11,100)testline !write out the lines to the final rxp file
                if(first==.true.) then
                  b4=testline
                  first=.false.
                else
                  twob4=b4
                  b4=testline
                endif
              else !when you hit the end of the file
                join(1)=twob4
                join(2)=b4 !this line has the gibberish chi value
                close(12)
              endif
            enddo
            header=.false.! marks that everything else is a not the first fragment file
            go to 1000!return to the top of the do loop and read in the next fragment's path 
!______________________________________________________________________________
!
!The next block of code applies to all fragments that are not the first fragment. we open and read in the first
!two lines into the the last two elements of join(4). join(4) is then used to generate information for the joining line
!and the missing chi value written out to an rxp file and  
          else 
            first=.true.! singles out the first line
            second=.true.! and the second line
            third=.true.!used to flag the 3rd
            do
              read(12,100,iostat=io2)testline !read in the rxp file line by line
              if (io2 ==0) then
                if(first==.true.) then
                  join(4)=testline
                  first=.false.
                elseif(second=.true.) then
                  join(5)=testline
                  read(join(1))
                  read(join(2))
                  read(join(3))
                  read(join(4))
                  !BLOCK USED TO WRITE AND EDIT THE JOIN AND TEST IT
                  second=.false.
                else
                  if(third==.true.) then
                    b4=testline
                    third=.false.
                  else
                    twob4=b4
                    b4=testline
                  endif
              else !when you hit the end of the file
                join(1)=twob4
                join(2)=b4 !this line has the gibberish chi value
                close(12)
              endif
            enddo
stop
end
