"""Top-level package for htau."""

__author__ = """Rui Xue"""
__email__ = 'rx.astro@gmail.com'
__version__ = '0.1.dev1'


import os
import logging
from astropy.config import paths


logger = logging.getLogger('htau')
logger.handlers = []

logger.setLevel(logging.DEBUG)

console_handler = logging.StreamHandler()
console_handler.setLevel('INFO')

logger.addHandler(console_handler)


cache_location = os.path.join(paths.get_cache_dir(), 'htau',)
