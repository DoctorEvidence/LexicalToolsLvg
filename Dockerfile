FROM eclipse-temurin:8-jre-alpine AS lvg_download

ARG LVG_URL=https://data.lhncbc.nlm.nih.gov/public/lsg/lvg/2027/release/lvg2027.tgz
ARG LVG_SHA1=f19d88f155fddf37b41fe522747f2257a6aaac3e

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

