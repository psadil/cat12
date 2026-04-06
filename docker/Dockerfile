# Dockerfile for image: psadil/cat12
# 
# Sample docker build command:
# docker build -f "Dockerfile" -t psadil/cat12 "."

FROM matlabruntime/r2024b/release/update8/f00660211002000000

RUN apt-get update && apt-get upgrade -y

COPY ./applicationFilesForMATLABCompiler /usr/bin/mlrtapp
RUN chmod -R a+rX /usr/bin/mlrtapp/*

# AdditionalPackages
RUN apt-get update && apt-get install --no-install-recommends -y \
    xvfb \
    x11-utils \
    libglx-mesa0 \
    libgl1-mesa-dri \
    && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# AdditionalInstructions
ENV MCRROOT=/opt/matlabruntime/R2024b
ENV MCR_INHIBIT_CTF_LOCK=1
ENV LD_LIBRARY_PATH=${MCRROOT}/runtime/glnxa64:${MCRROOT}/bin/glnxa64:${MCRROOT}/sys/os/glnxa64:${MCRROOT}/sys/opengl/lib/glnxa64
RUN /usr/bin/mlrtapp/spm12 --version

RUN if ["$(getent passwd appuser | cut -d: -f1)" = ""] ; then useradd -ms /bin/bash appuser ; fi
USER appuser

