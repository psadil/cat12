# cat12

To build, run `build_singularity` as root e.g.,

```bash
sudo ./build_singularity
```

Note that the build expects to find `./code/main`, so this command should be run from the root directory of the github repo.

The script `run_a2cps_segment` provides a minimal wrapper around the container.

```bash
./run_a2cps_segment mris/NS_northshore/bids/NS043021PVP/sub-043021/ses-PVP/anat/sub-043021_ses-PVP_T1w.nii.gz
```

To run cat_standalone with a different template, `<template>`, on T1w image, `<data>`, try

```bash
singularity run --cleanenv cat12.sif -b <template> <data>
```

Use the `--cleanenv` flag may not be necessary, depending on your host. When running with host Ubuntu 20.04, there were environment variables associated with Java that interfered with MATLAB. See the Singularity documentation on [environment variables](https://sylabs.io/guides/3.8/user-guide/environment_and_metadata.html?highlight=cleanenv#environment-overview)

## Prebuilt container

A verison of the container has been prebuilt and shared on <https://cloud.sylabs.io>. To use it, replace the container definition with `library://psadil/default/cat12`, e.g.,

```bash
singularity run --cleanenv library://psadil/default/cat12:sha256.008fc10d527c3f797085bb10c7ebbc3492a529f75a9145511906bb4b4a15c1de -b <template> <data>
```

That is, the container doesn't need to be downloaded manually; singularity should be able to recognize the location of `library://psadil/default/cat12`, download it automatically, and then cache the file.
