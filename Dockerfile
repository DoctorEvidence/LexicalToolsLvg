FROM eclipse-temurin:8-jre-alpine as lvg_download

ARG LVG_URL=https://data.lhncbc.nlm.nih.gov/public/lsg/lvg/2024/release/lvg2024.tgz
ARG LVG_SHA1=c9d14fc8cea8b9bf4e02dab3511ad5a446f9a744

WORKDIR /work

RUN echo "$LVG_SHA1  lvg.tar.gz" > lvg.tar.gz.sha1 && \
    wget -O lvg.tar.gz $LVG_URL && \
    cat lvg.tar.gz.sha1 && ls -lah && \
    sha1sum lvg.tar.gz && \
    sha1sum -c lvg.tar.gz.sha1

RUN mkdir -p /tmp/lvg

RUN tar zxf lvg.tar.gz -C /tmp/lvg --strip-components=1 && \
    ls -la /tmp/lvg

# Perform cleanup
# We don't need windows JRE or linux JRE
RUN rm -rf /tmp/lvg/bin/jreDist/*.exe

FROM eclipse-temurin:8-jre-alpine

COPY --from=lvg_download /tmp/lvg /opt/lvg

COPY lvg.sh /opt/lvg/bin

WORKDIR /opt/lvg

RUN ./install_linux.sh

ENTRYPOINT [ "/opt/lvg/bin/lvg.sh" ]

