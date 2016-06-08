program FreeEnergy
implicit none
integer::hit1(24,24),hit2(24,24),n,m,j
real*8::hitnet(24,24),fe
real*8::temp,k=0.0019872 !temperature is in kelvin, k is the boltzmann constant in kcal/mol*K
double precision::npdb
open(unit=10, file='/home/hephan/wca12rna_u24_umbloop4_v104_mc2/0000/hist')
open(unit=11, file='/home/hephan/wca12rna_u24_umbloop4_v104_mc2/0001/hist')
read(10,*)hit1
read(11,*)hit2
!
!will be used to test the read in/write out process of the pro!gram, can be ignored/commented out afterwards.
open(unit=12, file='test')
100 format(24(i7))
!write(12,100)hit1
!
!the above open statements (unit 10 and 11) are really clunky and are specific to 
!the case of what i've done to process the data. Ideally there should be a single 
!hit matrix stored in the hist file for each collective set of simulations performed. 
!In that case, just fee the hist file into the program via standard input
!read(*,*) hitnet
hitnet=real(hit1)+real(hit2)
write(*,*) 'Enter desired temperature (in kelvin)'
read(*,*) temp
write(*,*) 'How many pdb files were analyzed in total for this hit matrix?'
read(*,*) npdb
!write(12,100)hitnet
!fe=log(hitnet/npdb)*temp*k
101 format(i3,i3,f8.3)
open(13,file='fe.dat')
write(12,*)'Free energy (kcal/mol) at',int(temp),'Kelvins using',int(npdb),'samples'
do m=2,23
 do n=2,23
  if (hitnet(m,n)/=0) then
  fe=log(hitnet(m,n)/npdb)*k*temp
   write(12,101)m,n,fe
  endif
 end do
end do
stop
end
