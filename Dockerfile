FROM ubuntu:18.04

COPY CAT12.zip /tmp/CAT12.zip
COPY MCR_R2017b_glnxa64_installer.zip /tmp/MCR_R2017b_glnxa64_installer.zip

# install dependencies and prereqs
RUN apt-get update \
  && apt-get -y install wget nano unzip libxext6 libxt6 moreutils \
  && apt-get clean

# install Matlab MCR at /opt/mcr
ENV MATLAB_VERSION R2017b
ENV MCR_VERSION v93
RUN mkdir /tmp/mcr_install \
 && mkdir /opt/mcr \
 && unzip -q /tmp/MCR_R2017b_glnxa64_installer.zip -d /tmp/mcr_install \
 && /tmp/mcr_install/install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent
ENV MCRROOT /opt/mcr/${MCR_VERSION}

# install SPM12 Standalone at /opt/spm
ENV SPM_VERSION 12
ENV SPM_REVISION r7771
ENV CAT_VERSION 12.8
ENV CAT_REVISION r1904
ENV MCR_INHIBIT_CTF_LOCK 1
ENV SPM_HTML_BROWSER 0
RUN unzip -q /tmp/CAT12.zip -d /opt \
 && mv /opt/standalone /opt/spm \
 && /opt/spm/run_spm12.sh ${MCRROOT} --version \
 && chmod +x /opt/spm/spm12 /opt/spm/*.sh \
 && rm -rf /tmp/*
ENV PATH="${PATH}:/opt/spm/standalone"
ENV SPMROOT /opt/spm

ENTRYPOINT ["cat_standalone.sh"]
