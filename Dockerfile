# Dockerfile for image: cat12:12.9.0
# 
# Sample docker build command:
# docker build -f "Dockerfile" -t cat12:12.9.0 "."

FROM matlabruntime/r2024a/release/update6/f01dc2422104000000

COPY ./applicationFilesForMATLABCompiler/spm12 ./applicationFilesForMATLABCompiler/spm12.ctf /opt/spm/
RUN /opt/spm/spm12 --version
# RUN chmod -R a+rX /usr/bin/mlrtapp/*

# RUN if ["$(getent passwd appuser | cut -d: -f1)" = ""] ; then useradd -ms /bin/bash appuser ; fi
# USER appuser

ENTRYPOINT ["/opt/spm/spm12"]
CMD ["--help"]
