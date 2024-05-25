# escape=`
FROM debian:12 AS builder

WORKDIR /dl
ARG MAJOR_VERSION=12
ARG FULL_VERSION=1266A
RUN apt-get update && apt-get install -y wget unrar-free
RUN wget https://github.com/Kreeblah/XGecu_Software/raw/master/Xgpro/${MAJOR_VERSION}/xgproV${FULL_VERSION}_setup.rar
RUN unrar xgproV${FULL_VERSION}_setup.rar
RUN mkdir /xgprosrc
RUN unrar XgproV${FULL_VERSION}_Setup.exe /xgprosrc
RUN wget https://github.com/radiomanV/TL866/raw/master/wine/setupapi.dll && mv setupapi.dll /xgprosrc/setupapi.dll

FROM debian:12
HEALTHCHECK NONE
ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://volzit.de" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="volzit" `
      org.label-schema.description="XGecu Xgpro wine docker image" `
      org.label-schema.vcs-url="https://github.com/Apfelwurm/Xgpro-docker"

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y `
wine libusb-1.0-0:i386 &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

RUN useradd --user-group --system --create-home --no-log-init xgpro

COPY --chown=xgpro:xgpro --from=builder /xgprosrc /app/xgpro

CMD [ "wine" "/app/xgpro/Xgpro.exe" ]