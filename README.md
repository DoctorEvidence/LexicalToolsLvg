# LexicalTools

Docker image for LexicalTools https://lexsrv3.nlm.nih.gov/LexSysGroup/Projects/lvg/current/web/index.html .

The image is designed to use the data, not to run lvg.

PRs are welcomed.

## Build and publish

```
    docker login -u doctorevidence

    docker build -t doctorevidence/lexical-tools-lvg:2022 .
    docker tag doctorevidence/lexical-tools-lvg:2022 doctorevidence/lexical-tools-lvg:latest

    docker push doctorevidence/lexical-tools-lvg:2022
    docker push doctorevidence/lexical-tools-lvg:latest

    # To inspect the container you can sh into it
    docker run --rm -ti --entrypoint /bin/sh  doctorevidence/lexical-tools-lvg:2022
```

### Automated image publish on Docker Hub

The image is built and published automatically on DoctorEvidence Docker Hub account https://hub.docker.com/r/doctorevidence/lexical-tools-lvg .

Autobuilds are for `main` branch and tags composed of numbers (LVG release years, e.g. 2021).
