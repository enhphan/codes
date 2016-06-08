program diffFE
real*8::femat(100,100)=0,rfemat(100,100)=0,delta(100,100)=0,res(100,100)=0
real*8::avg,stdev,sqde,del
integer::n,m,r
character(len=30)::mfr
integer::l=0
open(unit=10,file='FEmat')
open(unit=11,file='r_FEmat')
open(unit=12,file='diffmat')
write(*,*) 'How many nucleotides are in the strand?'
read(*,*)r
write(mfr,'(a,i3,a)')'(',r,'f8.3)'
read(10,mfr)femat(1:r,1:r)
read(11,mfr)femat(1:r,1:r)
!delta=femat-rfemat
!100 format(35f8.3)
!write(12,mfr)delta(1:r,1:r)
do n=1,r
 do m=1,r
  del=femat(m,n)-rfemat(m,n)
  if(del<=0) then
   delta(m,n)=0
  else
   delta(m,n)=del
   l=l+1
  end if
 enddo
enddo
avg=sum(delta)/l
do n=1,r
 do m=1,r
  if (delta(m,n)/=0) then
   res(m,n)=(delta(m,n)-avg)**2
  end if
 enddo
enddo
write(12,mfr)delta(1:r,1:r)
sqde=sum(res)
stdev=SQRT(sqde/(l-1))
write(*,*)'The number of non-sero entries are',l
write(*,*)'The average error is',avg
write(*,*)'The sum of squared deviation is',sqde
write(*,*)'The standard deviation in the error is',stdev
stop
end

