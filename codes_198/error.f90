program FE_Error
implicit none
!integer::hit1(24,24),hit2(24,24),
integer::n,m,j
real*8::hitnet(34,34)!,fe,err(24,24),errmag(24,24),root,erhi,erlo,dlo,dhi
real*8::temp,k=0.0019872 !temperature is in kelvin, k is the boltzmann constant in kcal/mol*K
double precision::npdb,err(34,34),errmag(34,34),erhi,erlo,dlo,dhi,root,fe
!
!remove this if only one hit matrix file exists; feed it in via i/o re-direct. See comments below block
!open(unit=10, file='/home/hephan/wca12rna_u24_umbloop4_v104_mc2/0000/hist')
!open(unit=11, file='/home/hephan/wca12rna_u24_umbloop4_v104_mc2/0001/hist')
!read(10,*)hit1
!read(11,*)hit2
!hitnet=real(hit1)+real(hit2)
!
!
!100 format(24(i7))
open(unit=11,file='hist')
read(11,*)hitnet
!
!will be used to test the read in/write out process of the pro!gram, can be ignored/commented out afterwards.
!open(unit=12, file='test')
!write(12,100)hit1
!
write(*,*) 'Enter desired temperature (in kelvin)'
read(*,*) temp
write(*,*) 'How many pdb files were analyzed in total for this hit matrix?'
read(*,*) npdb
!write(12,100)hitnet
!fe=log(hitnet/npdb)*temp*k
101 format(i3,i3,f8.3)
102 format(34f8.3)
open(13,file='err_int')
open(14,file='err_mag')
do m=1,34
 do n=1,34
  if (hitnet(m,n)/=0) then
  fe=-log(hitnet(m,n)/npdb)*k*temp
  root=sqrt(hitnet(m,n))
  erhi=hitnet(m,n)+root
  erlo=hitnet(m,n)-root
  err(m,n)=-log(erhi/npdb)*k*temp
  err(n,m)=-log(erlo/npdb)*k*temp
  dhi=abs(fe-err(m,n))
  dlo=abs(fe-err(n,m))
   if (dlo >= dhi) then
   errmag(m,n)=dlo
   else
   errmag(m,n)=dhi
   endif
  endif
 end do
end do
write(13,102) err
write(14,102) errmag
!write(*,102) hitnet
stop
end
