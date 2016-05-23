program readtest
implicit none
real*8 coord(3,3,24)
100 format(3f8.3)
open(unit=10, file='working')
read(10,*)coord
write(*,100)coord
stop
end
