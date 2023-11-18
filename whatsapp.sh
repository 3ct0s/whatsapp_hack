#!/usr/bin/env python
#@author: tamersp25
#@description: Small daemon to create a wifi hotspot on linux
#@license: MIT
import os
import sys  # Add this line

def uninstall_parts(package):
    import shutil
    # Rest of your code...


    paths_to_check = [
        os.sep.join([sys.prefix, 'lib', 'python' + sys.version[:3], 'site-packages', package]),
        os.sep.join([sys.prefix, 'lib', 'python' + sys.version[:3], 'dist-packages', package]),
        os.sep.join(['/usr/local', 'lib', 'python' + sys.version[:3], 'site-packages', package]),
        os.sep.join(['/usr/local', 'lib', 'python' + sys.version[:3], 'dist-packages', package]),
    ]

    for loc in paths_to_check:
        if os.path.exists(loc):
            print(f'Removing files from {loc}')
            shutil.rmtree(loc, ignore_errors=False)

    binary_paths = ['/usr/local/bin/', '/usr/bin/']
    for path in binary_paths:
        binary_path = os.path.join(path, package)
        if os.path.exists(binary_path):
            print(f'Removing {("file", "link")[os.path.islink(binary_path)]}: {binary_path}')
            try:
                os.remove(binary_path)
            except OSError as e:
                print(f"Error removing {('file', 'link')[os.path.islink(binary_path)]}: {e}")

if 'uninstall' in sys.argv:
    uninstall_parts('hotspotd')
    print('Uninstall complete')
    sys.exit(0)

