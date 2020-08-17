

from . import cache_location

import os
import tarfile
from io import BytesIO

import urllib.request


from astropy.table import Column, Table, vstack
from astropy import units as u
from astroquery.nist import Nist

import logging
logger = logging.getLogger(__name__)


def download_meudon_uvdata(use_cache=True):
    """
    extract the UVDATA directory from the MeudonPDR tar file
    """

    url_src = 'https://ism.obspm.fr/files/PDRSourceCode/PDR1.5.4_200618_rev2065.tgz'
    uvdata_cache_location = cache_location+'/meudon_uvdata/'

    filenames = ['uvhd.dat', 'uvh2c29.dat', 'uvh2b29.dat']
    cache_exist = True
    for filename in filenames:
        if not os.path.isfile(uvdata_cache_location+'/'+filename):
            cache_exist = False

    logger.info("cache_exist: {}".format(cache_exist))

    if not (cache_exist and use_cache):

        with urllib.request.urlopen(url_src) as response, BytesIO() as tmpfile:

            s = response.read()
            tmpfile.write(s)
            tmpfile.seek(0)

            with tarfile.open(fileobj=tmpfile, mode='r:gz') as tar:
                members = [
                    member for member in tar.getmembers()
                    if '/data/UVdata/' in member.name
                ]
                for member in members:
                    member.name = os.path.basename(member.name)

                tar.extractall(members=members, path=uvdata_cache_location)

    return


def read_H2data():
    """ Simple def to read H2 data

    Returns
    -------
    Table of H2 lines

    References
    ----------
    * Abgrall et al. 1993, A&AS, 101, 323
    * Abgrall et al. 1993, A&AS, 101, 273
    * Meudon



    """

    H2_fil = '../data/uvdata/uvh2b29.dat'

    uvdata_cache_location = cache_location+'/meudon_uvdata/'
    h2_fil_list = ['uvh2b29.dat', 'uvh2c29.dat']

    h2data = []

    for h2_fil in h2_fil_list:

        colnames = ['index', 'ed', 'vl', 'jl', 'vu', 'jd',
                    'f', 'wl', 'gamma', 'ds_prob']
        print(uvdata_cache_location+h2_fil)
        data = Table.read(uvdata_cache_location+h2_fil,
                          format='ascii', data_start=1,
                          delimiter=' ', names=colnames)

        cmol = Column(['H2']*len(data), name='mol')
        data.add_column(cmol)

        data['wl'].unit = u.AA
        data.rename_column('wl', 'wrest')

        data['gamma'].unit = 1/u.s

        data.rename_column('ed', 'eu')
        data['eu'] += 1

        # Units

        data['Ref'] = 'Abgrall93-Meudon'

        h2data.append(data)

    h2data = vstack(h2data)

    return h2data


def read_HDdata():
    """ Simple def to read H2 data

    Returns
    -------
    Table of H2 lines

    References
    ----------
    * Abgrall et al. 1993, A&AS, 101, 323
    * Abgrall et al. 1993, A&AS, 101, 273
    * Meudon



    """

    H2_fil = '../data/uvdata/uvh2b29.dat'

    h2_fil_list = ['uvhd.dat']
    data_pth = '../data/uvdata/'

    hddata = []

    for h2_fil in h2_fil_list:

        colnames = ['ed', 'vl', 'jl', 'vu', 'jd',
                    'f', 'wl', 'dummy1', 'gamma', 'dprob']
        data = Table.read(data_pth+h2_fil, format='ascii.fixed_width_no_header', data_start=1,
                          delimiter=' ',  # guess=False,#fast_reader=False,
                          names=colnames)

        cmol = Column(['HD']*len(data), name='mol')
        data.add_column(cmol)

        data['wl'].unit = u.AA
        data.rename_column('wl', 'wrest')

        data['gamma'].unit = 1/u.s

        data.rename_column('ed', 'eu')
        data['eu'] += 1

        # Units

        data['Ref'] = 'Abgrall93-Meudon'

        hddata.append(data)

    hddata = vstack(hddata)

    return hddata


def read_HIdata():
    """
    HI data from NIST
    to-do:
        calculate gamma from Aij
    """
    return
