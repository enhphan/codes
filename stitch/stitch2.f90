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
101   format(7f8.3,2A40)
      character(len=180)::testline,b4,twob4,join
      character(len=40)resl(5),resr(5)
      integer::io2
      real::r(5),eta(5),theta(5),omega(5),chi(5),phil(5),phir(5)
      logical::first,second,third
!     unit=12, file=fragpath ; currently being used in the loop structure
!     unit=13, file=workingfile; for the join sement being tested 
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
                read(twob4,101)r(1),eta(1),theta(1),omega(1),xi(1),phil(1),phir(1),resl(1),resr(1)
                read(b4,101)r(2),eta(2),theta(2),omega(2),xi(2),phil(2),phir(2),resl(2),resr(2)
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
                  read(testline,101)r(4),eta(4),theta(4),omega(4),xi(4),phil(4),phir(4),resl(4),resr(4)
                  first=.false.
                elseif(second=.true.) then
                  read(testline,101)r(5),eta(5),theta(5),omega(5),xi(5),phil(5),phir(5),resl(5),resr(5)
                  !
                  !BLOCK USED TO GENERATE RETOXPlPr INFORMATION FOR THE JOINING LINE; 3rd elemtn of each array.
                  !ALSO FILLS IN A CHI VALUE FOR THE LAST RES OF LEADING FRAGMENT XI ANGLE (XI(2))
                  !
                  open(unit=13,file='working.rxp')!opens a working file into which we read the join
                  do n=1,5
                    write(13,101))r(n),eta(n),theta(n),omega(n),xi(n),phil(n),phir(n),resl(n),resr(n)
                  enddo
                  call nucleicmod(-1) !initiate defaults for variables; 'call init'
                  call nucleicmod(-2) !definine name of rxp input file and pdb output file 
                  !ASK CHI ABOUT HOW TO PROPERLY PASS THE desired name to this mod
                                   
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
                read(twob4,101)r(1),eta(1),theta(1),omega(1),xi(1),phil(1),phir(1),resl(1),resr(1)
                read(b4,101)r(2),eta(2),theta(2),omega(2),xi(2),phil(2),phir(2),resl(2),resr(2)
                close(12)
              endif
            enddo
stop
end
