c Copyright (C) 2014 C.H. Mak, All Rights Reserved
c
c getbang.f
c
c Calculate bond angle in radians

      real*8 function getbang(r1,r2,r3)
      implicit none
      real*8 r1(3),r2(3),r3(3)
      real*8 b1(3),b2(3)
      real*8 aa,bb,a,b,c
      real*8 cosine
      real*8 pi
      parameter (pi=3.14159265359D0)
      integer j

      do j=1,3
        b1(j)=r2(j)-r1(j)
        b2(j)=r3(j)-r2(j)
      enddo

      aa=b1(1)**2+b1(2)**2+b1(3)**2
      bb=b2(1)**2+b2(2)**2+b2(3)**2
      a=sqrt(aa)
      b=sqrt(bb)

      c=b1(1)*b2(1)+b1(2)*b2(2)+b1(3)*b2(3)
      cosine=-c/a/b
      if (cosine.lt.-1.D0) then
        getbang=pi
      elseif (cosine.lt.1.D0) then
        getbang=acos(cosine)
      else
        getbang=0.D0
      endif

      return
      end
