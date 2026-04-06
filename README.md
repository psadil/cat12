# cat12

## Preparation

- Install MATLAB R2024b
  - CAT12 assumes that the renderer will be opengl. Starting with 2025a, it is no longer possible to select the figure renderer, and so some CAT12 functions don't work (notably, the report generation).
- Install SPM12
  - ~/matlab/toolbox/spm12
  - r7771
- Install CAT12 (12.9)
  - ~/matlab/toolbox/spm12/toolbox/cat12
- Add spm12 folder to search path

## Compile Standalone

Build standalone cat12/spm12 with modified [`spm_make_standalone`](spm_make_standalone.m) (mostly the same as spm12's version of spm_make_standalone, but modified to ensure extra toolboxes have been included).

```bash
~/matlab/R2024b/bin/matlab -nodesktop -batch spm_make_standalone
```

## Build Docker

First, prepare the docker context.

```bash
~/matlab/R2024b/bin/matlab -nodesktop -batch prepare_docker_context
```

This will prepare the files in the `docker/` folder, and it will print out several commands can be used to make the docker images

```bash
docker build -f "/home/psadil/Desktop/cat12/docker/matlabruntimebase/Dockerfile.deps" -t matlabruntimebase/r2024b/release/update8 "/home/psadil/Desktop/cat12/docker/matlabruntimebase"
docker build -f "/home/psadil/Desktop/cat12/docker/matlabruntime/Dockerfile.runtime" -t matlabruntime/r2024b/release/update8/f00660211002000000 "/home/psadil/Desktop/cat12/docker/matlabruntime"

# do not run the third one
# docker build -f "/home/psadil/Desktop/cat12/docker/Dockerfile" -t psadil/cat12 "/home/psadil/Desktop/cat12/docker"
```

The third one has been commented out because some modifications to the MATLAB-generated dockerfile are needed. Those are mainly to add execute permissions and change file ownership. Importantly, the spm12 entrypoint command has been wrapped with a call to `xvfb-run`, which launches a display that MATLAB can detect. It's this virtual frame buffer that allows the renderer to be set to opengl. Unlike some of the documentation, this means that there is no need to pass an evironment variable for the DISPLAY into the container.

## Run apptainer

```bash
# see help for spm12
apptainer run docker://psadil/cat12 -h

# run batch job
apptainer run -B $PWD docker://psadil/cat12 batch $PWD/batch.m
```
