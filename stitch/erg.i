c erg.i

      real*8 sbbtot
      real*8 essvtot,essctot,sssw1tot,essw2tot,esshbtot
      real*8 emmtot
      real*8 esmtot
      real*8 ecitot

      common /erg/ sbbtot,essvtot,essctot,sssw1tot,essw2tot,esshbtot,
     &             emmtot,esmtot,ecitot


! range of correlation along backbone
      integer sbbrange
      parameter (sbbrange=3)
      real*8 sbb(nrxpX),osbb(nrxpX)

      common /erg_1/ sbb,osbb

