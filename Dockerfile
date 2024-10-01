# Dockerfile for image: cat12:12.9.0
# 
# Sample docker build command:
# docker build -f "Dockerfile" -t cat12:12.9.0 "."

FROM matlabruntime/r2024b/release/update0/f016e1211002000000

COPY --chmod=555 ./applicationFilesForMATLABCompiler/spm12 ./applicationFilesForMATLABCompiler/spm12.ctf /opt/spm/
ENV MCR_INHIBIT_CTF_LOCK=1
RUN /opt/spm/spm12 --version
# RUN chmod -R a+rX /usr/bin/mlrtapp/*

# RUN if ["$(getent passwd appuser | cut -d: -f1)" = ""] ; then useradd -ms /bin/bash appuser ; fi
# USER appuser

ENTRYPOINT ["/opt/spm/spm12"]
CMD ["--help"]
