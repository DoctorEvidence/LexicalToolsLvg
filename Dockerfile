FROM eclipse-temurin:8-jre-alpine as lvg_download

ARG LVG_URL=https://data.lhncbc.nlm.nih.gov/public/lsg/lvg/2022/release/lvg2022.tgz
ARG LVG_SHA1=e6d81e6e47bba947329880cca750215148594aab

WORKDIR /work

RUN echo "$LVG_SHA1  lvg.tar.gz" > lvg.tar.gz.sha1 && \
    wget -O lvg.tar.gz $LVG_URL && \
    cat lvg.tar.gz.sha1 && ls -lah && \
    sha1sum lvg.tar.gz && \
    sha1sum -c lvg.tar.gz.sha1

RUN mkdir -p /tmp/lvg

RUN tar zxf lvg.tar.gz -C /tmp/lvg --strip-components=1 && \
    ls -la /tmp/lvg

FROM eclipse-temurin:8-jre-alpine

COPY --from=lvg_download /tmp/lvg /opt/lvg

COPY lvg.sh /opt/lvg/bin

WORKDIR /opt/lvg

ENTRYPOINT [ "/opt/lvg/bin/lvg.sh" ]

