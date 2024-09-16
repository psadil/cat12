# cat12

Build standalone cat12 and dockerfiles with [`make_standalone`](code/make_standalone.m).

Sample Docker Run Command:

```bash
docker run --rm -e "DISPLAY=:0" -v '/tmp/.X11-unix':'/tmp/.X11-unix' cat12:12.9.0
```

NOTE: the build command expects to find `applicationFilesForMATLABCompiler/spm12.ctf`, which is build with [`make_standalone`](code/make_standalone.m). This file is 2G and so not hosted on GitHub.

