htau
====

A High-Resolution Molecular Hydrogen Optical Depth Template in the Lyman-Werner Absorption Band

Description & Features (planned)
--------------------------------

This Python package ***will*** offer the tool to create and use high-resolution molecular hydrogen optical depth templates in the `Lyman-Werner <https://ui.adsabs.harvard.edu/abs/1993JMoSp.157..512A>`_ absorption bands.
The principles and advantages of such templates for relevant FUV spectroscopy analysis were presented in `McCandliss 2003 <https://ui.adsabs.harvard.edu/abs/2003PASP..115..651M/abstract>`_.
Despite following the same idea, ``htau`` is different in several aspects:

+ The package is fully written in ``Python`` (instead of ``IDL``) and takes the advantages of existing Python libraries/framework (`astropy <https://www.astropy.org>`_, `linetools <https://linetools.readthedocs.io/en/latest>`_, etc.)
+ meet open-source standards with modern documentation
+ automatically compile HI and H2 atomic/molecular data from online sources (not distributed along with ``htau``)
+ offers a command-line interface to efficiently generate templates locally to your specifications (e.g. spectral resolution, sampling of *b*-values), therefore no need to distribute bulky pre-calculated tables

.. note::
    
    I wrote a primitive `IDL version <./pro>`_ of ``htau`` many years ago, which was an attempt to create similar templates to `McCandliss 2003 <https://ui.adsabs.harvard.edu/abs/2003PASP..115..651M/abstract>`_ with more efficient computing methods, finer resolution/*b*-value sampling,  and updated atomic/molecular data.
    That effort was used in `Welty, Xue, & Wong 2012 <https://ui.adsabs.harvard.edu/abs/2012ApJ...745..173W/abstract>`_.
    
 

TODO
----

- parse the atomic/molecular data of H2/HD/HI/DI from sources into the linetools.LineList format
- derive tau tables per rotational band on a log(wave)-b grid 
- spectrum "maker" (interpolation/gridding/flux-conservation)
- translate ``calc_igmtau.pro`` into Python

