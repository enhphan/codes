program arrayreadtest
implicit none
character(len=10)::test(3),string

test(1)='1111XX1111'
test(2)='2222XX2222'
test(3)='3333XX3333'
write(*,*)test(1)
read(test(1),'(a10)')string
write(*,*)string(4:6)
write(*,*)string(5:7)
write(*,*)string(6:8)
open(unit=10,file=test(3))
write(10,*)'abcdefghij'
write(*,*)test(3)
stop
end

