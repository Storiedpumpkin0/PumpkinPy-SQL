# This will clean the output folder

# taken from https://stackoverflow.com/questions/185936/how-to-delete-the-contents-of-a-folder

import os, shutil
folder = 'output'
for filename in os.listfir(folder):
    file_path = os.path.join(folder, filename)
    try:
        if os.path.isfile(file_path) or os.path.islink(file_path):
            os.unlink(file_path)
        elif os.path.isdir(file_path):
            shutil.rmtree(file_path)
    except Exception as e:
        print('Failed to delere %s. Reason: %s' % (file_path, e))