import os
import shutil
from subprocess import check_call

OUTDIR = "_output"

def copyinto(src, dst, symlinks=False, ignore=None):
    '''
    Copy files and subdirectoryes from src into dst.

    http://stackoverflow.com/questions/1868714/how-do-i-copy-an-entire-directory-of-files-into-an-existing-directory-using-pyth
    '''
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.isdir(s):
            shutil.copytree(s, d, symlinks, ignore)
        else:
            shutil.copy2(s, d)

def render():
    for item in [i for i in os.listdir(OUTDIR) if '.md' in i]:
        print(item)
        name = os.path.join(OUTDIR, item.split('.md')[0])
        cmd = "pandoc -w html -o {f}.html {f}.md".format(f=name)
        check_call(cmd.split())
        os.remove("{}.md".format(name))

    #shutil.rmtree(os.path.join(OUTDIR,".git"))

if __name__ == "__main__":

    copyinto('.', OUTDIR)
    render()
