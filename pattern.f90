program pattern
implicit none
real*8::coord(3,3,24)
character(len=80)::line
integer::io,n,res=1,m=1
open(unit=10,file='x.pdb_9999')
open(unit=11,file='readin')
open(unit=12,file='working')
open(unit=13,file='xyzcheck')
100 format(A80)
101 format(3f8.3)
102 format(A25)
103 format(x3f8.3)
do
read(10,100,iostat=io)line
 if (io < 0) then
  exit
 else if (io == 0) then
  if ( line(13:16) == " C1'" .or. line(13:16) == ' N1' .or. line(13:16)==' C2') then
   if (line(13:16) /= " C2'") then
   !read(line(31:54),101) coord(1,:,:),coord(2,m,res),coord(3,m,res)
   write(12,*) adjustl(adjustl(line(31:54)))
   endif
  endif
 end if
!  end if
end do
close(12)
open(unit=12, file='working')
!102 format(30x3f8.3)
read(12,*)coord
 !endif
write(13,101) coord
stop
end

