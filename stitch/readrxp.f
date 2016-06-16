c Copyright (C) 2014, C.H. Mak,  All Rights Reserved
c
c readrxp.f
c
c
c Read a rxp file.
c 
c Data in rxp() contain C1'-N-N-C1' reto, xi, and phiL and phiR.
c
c         (3)Cb      Cb(6)         Cb(9)
c           /         \            |
c       (2)N1--------- N9(5)-------N1(8)
c         /            |           \
c     (1)C1'           C1'(4)       C1'(7)
c
c Reto (r,eta,theta,omega) is defined for atomes 1-2-5-4.  The shift, xi, 
c is defined as the torsion angle 2-5-4-8.  The base rotation angles are 
c defined as phiL = 5-1-2-3 and phiR = 2-4-5-6 for each reto.  Cb is C2 for 
c pyrimidine and C4 for purines.
c
c First 56 characters of each line in a .rxp file contains reto, xi, phiL and 
c phiR.  The next 80 characters are read into rxpinfo as text to be decoded 
c later.
c
c
c Example of a single line in rxpinfo:
c  60585 60586  C1'  N1    C  121 9 60605 60606  C1'  N1    C  122 9 # 60584
c
c Columns:
c 0        1         2         3         4         5         6         7
c 123456789012345678901234567890123456789012345678901234567890123456789012345678
c
c
c COLUMNS   LEN   DATA TYPE       CONTENTS                            
c ------------------------------------------------------------------------------
c  2 -  6    5    Integer         Atom serial number of the left C1'.
c  8 - 12    5    Integer         Atom serial number of the left N.
c 14 - 17    4    Character*4     Atom name of the left C1'.
c 19 - 22    4    Character*4     Atom name of the left N.
c 24 - 26    3    Character*3     Residue name of the left base.
c 28 - 31    4    Integer         Residue seq number of the left base.
c 33         1    Character*1     Chain ID of the left base.
c 35 - 39    5    Integer         Atom serial number of the right C1'.
c 41 - 45    5    Integer         Atom serial number of the right N.
c 47 - 50    4    Character*4     Atom name of the right C1'.
c 52 - 55    4    Character*4     Atom name of the right N.
c 57 - 59    3    Character*3     Residue name of the right base.
c 61 - 64    4    Integer         Residue seq number of the right base.
c 66         1    Character*1     Chain ID of the right base.


      subroutine readrxp(iounit)

      implicit none
      include 'rxp.i'
      integer iounit
      integer j
      character*160 line


! read rxp data
      nrxp=0
10    continue
      read (iounit,'(a160)',end=9) line
      if (line(1:1).eq."#") goto 10

      nrxp=nrxp+1
      if (nrxp.gt.nrxpX) then
        write(*,*) '[readrxp] nrxp too large'
      endif
      read (line(1:56),*,err=11) (rxp(j,nrxp),j=1,7)
      read (line(57:136),'(a80)') rxpinfo(nrxp)
      goto 10

! if error reading rxp, assign a nonsense value to RETO
11    continue
      rxp(1,nrxp)=999.9
      if (line(1:3).eq.">>>") then 
        read (line(60:139),'(a80)') rxpinfo(nrxp)
      else
        read (line(57:136),'(a80)') rxpinfo(nrxp)
      endif
      goto 10

9     continue


      return
      end
