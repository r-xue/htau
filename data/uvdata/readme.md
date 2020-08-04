## File origin:

All data files are extracted from the [Meudon PDR source code](http://pdr.obspm.fr/), without any alteration:

    PDR1.5.4_200618_rev2065/data/UVdata/
        uvh_new.dat
        uvd.dat
        uvh2b29.dat
        uvh2c29.dat
        uvhd.dat

Data column formating can be inferred from: 

    PDR1.5.4_200618_rev2065/src/
        PXDR_INITIAL.f90

## Data Columns

H2 Lyman/Werner bands (all v) J <= 29

- `uvh2b29.dat` : *Lyman Bands*:   1st elec. state X -> 2nd elec. state B
- `uvh2c20.dat` : *Werner Bands*:   1st elec. state X -> 3rd elec. state C

    * c1 (idx):         Index
    * c2 (ed):          1=Lyman (B-X);  2=Werner (C-X) (eu-el)
    * c3 (vpp/vl):      lower-state vib. level
    * c4 (jpp/jl):      lower-state rot. level
    * c5 (vp/vu):       upper-state vib. level
    * c6 (jd):          upper-state rot. level - lower-state rot. level (jpp-jp)
      * 1=R
      * 0=Q
      * -1=P
    * c7 (f):           oscillator strength
    * c8 (wv):          wavelength (Angstrom)
    * c9 (gamma):       upper-state inverse radiative lifetime / damping constant (s-1)
    * c10:              upper-statte dissociation probability

    The transition label convention can be: 
    * <L/W><c5>-<c3><R/P/Q>(<abs(c6)>)
    * <B/X><c5>-<c3><R/P/Q>(<c4>)

    g_j:
    * if (j mod 2) eq 0 then g_j=2*j+1  
    * if (j mod 2) eq 1 then g_j=3*(2*j+1)  

HD Lyman/Werner bands

- `uvhd.dat` :

    * c1 (ed):          1=Lyman;  2=Werner (eu-el)
    * c2 (vpp/vl):      lower-state vibrational level (nvl)
    * c3 (jpp/jl):      lower-state rotational level (njl)
    * c4 (vp/vu):       upper-state vibrational level (nvu)
    * c5 (jd):          upper-state rot. level - lower rot. level (jpp-jp) 
    * c6 (f):           oscillator strength
    * c7 (wv):          wavelength (Angstrom)
    * c8 (gamma):       upper-state inverse radiative lifetime / damping constant (s-1)
    * c9:               upper-statte dissociation probability
    * c11 :             asterisk or empty

HI/DI data:

- `uvh_new.data` : HI Lyman series
- `uvd.data`: DI Lyman series

    * c1 (nd):          n_upper - n_lower(=1)
    * c2 (f):           oscillator strength
    * c3 (wv):          wavelength (Angstrom)
    * c4 (gamma):       inverse radiative lifetime of upper-state (s-1)
    * c5:               dummy

## Reference:

### H2 Lyman-Werner Bands (`uvh2v29.dat`,`uvh2c29.dat`):
* [Abgrall et al. 1993](https://ui.adsabs.harvard.edu/abs/1993A&AS..101..273A)
* [Abgrall et al. 1993](https://ui.adsabs.harvard.edu/abs/1993A&AS..101..323A)
* [Abgrall et al. 1993](https://ui.adsabs.harvard.edu/abs/1993JMoSp.157..512A)

### HD Lyman-Werner Bands (`uvhd.dat`):
* [Abgrall & Roueff 2006](ttps://ui.adsabs.harvard.edu/abs/2006A&A...445..361A)


### HI/DI Lyman series (`uvh_new.dat`,`uvd.dat`)
* [Wiese et al. 2008](https://ui.adsabs.harvard.edu/abs/2009JPCRD..38..565W)
* also see Palchikov (1998), Wiese et al. (1996), Morton et al. 2003, Wiese at al.2009

### Meduon PDR:

* [Le Petit et al. 2006](https://ui.adsabs.harvard.edu/abs/2006ApJS..164..506L/abstract)



---

* 150321 RX   summary for `htau`
* 200731 RX   additional comments for `linetools`
