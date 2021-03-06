program r_paircheck
!
!
      implicit none
      character(len=80)::file1,line,mfr,mfi
      real*8::coord(3,3,100)=0,rc1(3)=0,rn1(3)=0,rn2(3)=0,rc2(3)=0
      real*8::getbond,getbang,getbtor,bond,ang1,ang2,tor,x,y,z
      integer::n=0,l=0,m=0,j=0,k=0,hit(100,100)=0,io,io1,r,iowork
      open(unit=11, file='filename')
      open(unit=12, file='r_test_in')
      open(unit=13, file='r_test_coord')
!     open(unit=14, file='dist')
!     open(unit=15, file='bang1')
!     open(unit=16, file='bang2')
!     open(unit=17, file='bangtor')
      open(unit=18, file='r_hist')
!     open(unit=19, file='hitrecord')
100   format(A80)
101   format(F8.3,F8.3,F8.3)
!
!
!
!     Loop over the all of the different files to read in their coordinates starts here.
!     comment out the loop to read in a single file for testing purposes.
!
!
      read(*,*)r
      write(mfr,'(a,i3,a)')'(',r,'f8.3)'
  
      do
31      read(11,100,iostat=io)file1 !read in the name of the simulation output file
        if (io < 0) then
          exit
        else if (io == 0) then
          open(unit=23, file=file1) !open the output file stored in file1
          open(unit=22, file='r_working') 
          do
            read(23,100,iostat=io1)line !read the file whose name is in file1 line by line and search for the C1', N1, and C2 coordinates
            if (io1 < 0) then
              exit
            else if (io1 == 0) then !search criteria for coordinates
!             write(*,*)line
              if ( line(13:16) == " C1'" .or. line(13:16) == ' N1' .or. line(13:16)==' C2') then
                if (line(13:16) /= " C2'") then
                  read(line(31:54),"(3f8.3)") x,y,z !write the CNC coordinate of each residue into the working file
                  write(22,101)x,y,z
                endif
              endif
            endif
          enddo!finishes the extraction of cnc coordinates into the working file
          close(22) !closing to reset the place holder in the wroking filei


          open(unit=22,file='r_working') !reopens the working file and read coordinates into the coord array
          read(22,101,iostat=iowork)coord(:,:,1:r)
          if(iowork /= 0) then
            write(*,*)'error reading pdb',file1
            close(23)
            close(22)
            goto 31

          else
            close(22)
            write(13,mfr)coord(:,:,1:r)
!
!     the line below writes out the collection of coordinates for double checking
!     commentout as needed.

            do m=1,r-1 !loop over the coordinates of the 24 residue in the polyuracil pairwise
              j=m+1 
              do l=j,r !
                rn1(1)=coord(1,2,m)
                rn1(2)=coord(2,2,m)
                rn1(3)=coord(3,2,m)
                rn2(1)=coord(1,2,l)
                rn2(2)=coord(2,2,l)
                rn2(3)=coord(3,2,l)
!               write(*,*) rn1  
                bond=getbond(rn1,rn2)
                  if (bond<=9.5 .and. bond>=8.5) then
!                   write(14,*) bond
!                   rc1(1)=coord(1,1,m)
!                   rc1(2)=coord(2,1,m)
!                   rc1(3)=coord(3,1,m)
!                   rc2(1)=coord(1,1,l)
!                   rc2(2)=coord(2,1,l)
!                   rc2(3)=coord(3,1,l)
!                   ang1=getbang(rc1,rn1,rn2)
!                   if (ang1<=2.5307274154 .and. ang1>=1.8325957146) then
!                     write(15,*)m,l,ang1
!                     ang2=getbang(rn1,rn2,rc2)
!                   if (ang2<=2.5307274154 .and. ang2>=1.8325957146) then
!                     write(16,*)m,l,ang2
!                     tor=getbtor(rc1,rn1,rn2,rc2)
!                   if (abs(tor)<=0.6981317008) then
!                     write(17,*),m,l,tor
        hit(m,l)=hit(m,l)+1
         !write(19,*)file1,m,'and',l,bond,ang1,ang2,tor
         write(*,*)file1,m,'and',l,bond!,ang1,ang2,tor
         !endif 
       ! endif
      ! endif
      endif
     end do
    end do
!if !check if the two residue are close enough together
   !then !place holder for result of GETBANG.F
     !if i! check if the two residue forms the correct cnc bond angle
      !then !place holder for result of torsion angle
       !if !check the tosion angles is sufficiently small
        !then hit(l,m,n)=1 !final check for torsion angle
       !else hit(l,m,n)=0
     !else hit(l,m,n)=0 !exit condition for bond angle
   !else hit(l,m,n)=0 !exit condition for bond length
  !end if !end of if loop for a given m,n pair
!end do!end the loop over l, thie second residue of the pairing
! end loop over m, the first residue of the pairing
! end loop over n, the index of the pdb output.
 endif
 endif
end do
write(mfi,'(a,i3,a)')'(',r,'i7)'
!103 format(r(i7))
!write(*,103)hit
write(18,mfi) hit(1:r,1:r)
stop 
end
