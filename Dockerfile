FROM adoptopenjdk/openjdk11:alpine as lvg_download

ARG LVG_URL=https://lexsrv3.nlm.nih.gov/LexSysGroup/Projects/lvg/current/release/lvg2020.tgz

RUN wget -O lvg.tar.gz $LVG_URL

RUN mkdir -p /tmp/lvg

RUN tar zxf lvg.tar.gz -C /tmp/lvg --strip-components=1 && \
    ls -la /tmp/lvg

FROM adoptopenjdk/openjdk11:alpine

COPY --from=lvg_download /tmp/lvg /opt/lvg

COPY lvg.sh /opt/lvg/bin

ENTRYPOINT [ "/opt/lvg/bin/lvg.sh" ]

