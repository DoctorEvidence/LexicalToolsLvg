# LexicalTools

Docker image for LexicalTools https://lhncbc.nlm.nih.gov/LSG/Projects/lvg/current/web/index.html . .

The image is designed to use the data, not to run lvg.

PRs are welcomed.

## Build and publish

```shell
    docker login -u doctorevidence

    # Build using bake file, recomended
    TAG=2025-1 \
    LVG_URL=https://data.lhncbc.nlm.nih.gov/public/lsg/lvg/2025/release/lvg2025.tgz \
    LVG_SHA1=777aad51bef5edbe434b46208a66d96e626771b1 \
    docker bake --push

    # Alternative 
    docker build -t doctorevidence/lexical-tools-lvg:2025-1 . --load
    docker tag doctorevidence/lexical-tools-lvg:2025-1 doctorevidence/lexical-tools-lvg:latest

    docker push doctorevidence/lexical-tools-lvg:2025-1
    docker push doctorevidence/lexical-tools-lvg:latest

    # To inspect the container you can sh into it
    docker run --rm -ti --entrypoint /bin/sh  doctorevidence/lexical-tools-lvg:2024
```

### Automated image publish on Docker Hub

The image is built and published automatically on DoctorEvidence Docker Hub account https://hub.docker.com/r/doctorevidence/lexical-tools-lvg .

Autobuilds are for `main` branch and tags composed of numbers (LVG release years, e.g. 2021).
