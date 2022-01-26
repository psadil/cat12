# cat12

To build, run `build_singularity` as root e.g.,

```bash
sudo ./build_singularity
```

Note that the build expects to find a few files:
- `./code/main` 
- ./CAT12.zip (zipped standalone copy of CAT12, https://www.jiscmail.ac.uk/cgi-bin/wa-jisc.exe?A2=ind2102&L=SPM&P=R8713)
- ./MCR_R2017b_glnxa64_installer.zip (e.g., `wget https://ssd.mathworks.com/supportfiles/downloads/R2017b/deployment_files/R2017b/installers/glnxa64/MCR_R2017b_glnxa64_installer.zip`)

The script `run_a2cps_segment` provides a minimal wrapper around the container.

```bash
./run_a2cps_segment T1w.nii.gz
```

To run cat_standalone with a different template, `<template>`, on T1w image, `<data>`, try

```bash
singularity run --cleanenv cat12.sif -b <template> <data>
```

Use the `--cleanenv` flag may not be necessary, depending on your host. When running with host Ubuntu 20.04, there were environment variables associated with Java that interfered with MATLAB. See the Singularity documentation on [environment variables](https://sylabs.io/guides/3.8/user-guide/environment_and_metadata.html?highlight=cleanenv#environment-overview)

## Prebuilt container

A verison of the container has been prebuilt and shared on <https://cloud.sylabs.io>. To use it, replace the container definition with `library://psadil/default/cat`, e. g.,

```bash
singularity run --cleanenv library://psadil/default/cat:0.0.1 -b <template> <data>
```
