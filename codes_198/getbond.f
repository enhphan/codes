c Copyright (C) 2010 C.H. Mak, All Rights Reserved
c
c getbond.f
c
c Calculate bond length

      real*8 function getbond(r1,r2)
      implicit none
      real*8 r1(3),r2(3)
      real*8 r

      getbond=sqrt((r1(1)-r2(1))**2+(r1(2)-r2(2))**2+(r1(3)-r2(3))**2)

      return
      end
