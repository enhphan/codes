program test
implicit none
character(len=180):: teststring
teststring='RRRRRRRREEEEEEEETTTTTTTTOOOOOOOOXXXXXXXXPLPLPLPLPLPRPRPRPR'
write(*,"(a8)")teststring(33:40)
stop
end
