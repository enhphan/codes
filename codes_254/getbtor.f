c Copyright (C) 2014 C.H. Mak, All Rights Reserved
c
c getbtor.f
c
c Calculate torsion angle in radians

      real*8 function getbtor(r1,r2,r3,r4)
      implicit none
      real*8 r1(3),r2(3),r3(3),r4(3)
      real*8 b1(3),b2(3),b3(3)
      real*8 rr,r
      real*8 a,b
      integer j

      do j=1,3
        b1(j)=r2(j)-r1(j)
        b2(j)=r3(j)-r2(j)
        b3(j)=r4(j)-r3(j)
      enddo

      rr=b2(1)**2+b2(2)**2+b2(3)**2
      r=sqrt(rr)

      a = 
     &  (rr)*
     &  (-(b1(3)*b2(2)*b3(1)) + b1(2)*b2(3)*b3(1) + 
     &    b1(3)*b2(1)*b3(2) - b1(1)*b2(3)*b3(2) - 
     &    b1(2)*b2(1)*b3(3) + b1(1)*b2(2)*b3(3))

      b = 
     &  (-(b1(2)*b2(1)) + b1(1)*b2(2))*
     &   (-(b2(2)*b3(1)) + b2(1)*b3(2)) + 
     &  (b1(3)*b2(1) - b1(1)*b2(3))*
     &   (b2(3)*b3(1) - b2(1)*b3(3)) + 
     &  (-(b1(3)*b2(2)) + b1(2)*b2(3))*
     &   (-(b2(3)*b3(2)) + b2(2)*b3(3))

      getbtor=atan2(a/r,b)

      return
      end
