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
