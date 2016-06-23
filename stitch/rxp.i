c rxp.i

      integer nrxpX
      parameter (nrxpX=3000)
      real*8 rxp(7,nrxpX)
      character*80 rxpinfo(nrxpX)
      integer nrxp
      logical isrna
      character*3 resnm(nrxpX+1)
      integer ncnc

      common /rxp/ rxp,rxpinfo,nrxp,
     &             isrna,resnm,ncnc


      real*8 cncxyz(3,3,nrxpX+1)
      real*8 r9xyz(3,9,nrxpX),r9xyz2(3,9,nrxpX)
      real*8 ocncxyz(3,3,nrxpX+1)
      real*8 or9xyz(3,9,nrxpX),or9xyz2(3,9,nrxpX)
      real*8 po4xyz(3,4,nrxpX)

      common /rxp_1/ cncxyz,r9xyz,r9xyz2,
     &              ocncxyz,or9xyz,or9xyz2,
     &              po4xyz

