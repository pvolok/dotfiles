#!/usr/bin/env python3

import os

from pathlib import Path

HOME = os.path.expanduser('~')
HERE = HOME + '/dev/dotfiles'

# Link vim config
vimrc_link = Path(HOME + '/.vimrc')
vimrc_file = HERE + '/vimrc'
if not (vimrc_link.exists() and vimrc_link.samefile(vimrc_file)):
    if vimrc_link.exists():
        print('Removing old .vimrc')
        vimrc_link.unlink()
    print('Linking .vimrc')
    vimrc_link.symlink_to(HERE + '/vimrc')
