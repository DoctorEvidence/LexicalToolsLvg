# AGENTS.md

Guidance for AI coding agents working in this repository.

## What this is

A Docker packaging of the NLM **Lexical Tools (LVG)** release
(https://lhncbc.nlm.nih.gov/LSG/Projects/lvg/current/web/index.html), published as
`doctorevidence/lexical-tools-lvg` on Docker Hub. There is no application code here — just the
image definition and a launcher script. The image exists mainly so downstream images can copy the
LVG data from `/opt/lvg`; running `lvg` is secondary.

## Files

| File | Purpose |
| --- | --- |
| `Dockerfile` | Two-stage build. Stage `lvg_download` fetches the release tarball, verifies its SHA1, extracts to `/tmp/lvg`, drops Windows `.exe` JRE files. Final stage copies to `/opt/lvg`, adds `lvg.sh`, runs `./install_linux.sh`. Base image: `eclipse-temurin:8-jre-alpine` (LVG needs Java 8). |
| `docker-bake.hcl` | Preferred build entrypoint. Variables `REPO`, `TAG`, `LVG_URL`, `LVG_SHA1`; builds `linux/amd64` only. |
| `lvg.sh` | Container `ENTRYPOINT` (`/opt/lvg/bin/lvg.sh`). Replaces the upstream script with a fixed `LVG_DIR=/opt/lvg` and the classpath pointing at `lib/lvg<YEAR>dist.jar`. |
| `README.md` | Build/publish instructions. |
| `CHANGELOG.md` | One `### <YEAR>` section per release, newest first. |

`.clj-kondo/` and `.lsp/` are editor leftovers; ignore them.

## Yearly release upgrade (the most common task)

LVG ships one release per year. The release year is hard-coded in **several places that must stay
in sync** — missing one yields an image that builds but fails at runtime (wrong jar) or downloads
the old release:

1. `Dockerfile` — `ARG LVG_URL` and `ARG LVG_SHA1` defaults.
2. `docker-bake.hcl` — `LVG_URL` and `LVG_SHA1` variable defaults.
3. `lvg.sh` — jar name in `CLASSPATH` (`lvg<YEAR>dist.jar`). Verify the actual jar name inside the
   new tarball's `lib/` directory.
4. `README.md` — example tag, URL and SHA1 in the build commands.
5. `CHANGELOG.md` — add a new `### <YEAR>` section at the top.

URL pattern: `https://data.lhncbc.nlm.nih.gov/public/lsg/lvg/<YEAR>/release/lvg<YEAR>.tgz`.
Compute the SHA1 yourself from the downloaded tarball (`sha1sum lvg<YEAR>.tgz`); never guess or
copy a checksum from an untrusted source. The build fails if the checksum doesn't match — that is
intended. Note the release tarball is large (multiple GB).

See commit `3737267` for a reference upgrade diff.

## Build & verify

```shell
# Build locally without pushing
TAG=<YEAR>-1 docker bake --load
# or
docker build -t doctorevidence/lexical-tools-lvg:<YEAR>-1 . --load

# Smoke test: lvg should transform input on stdin
echo "running" | docker run --rm -i doctorevidence/lexical-tools-lvg:<YEAR>-1 -f:b

# Inspect contents
docker run --rm -ti --entrypoint /bin/sh doctorevidence/lexical-tools-lvg:<YEAR>-1
```

There is no test suite or CI in this repo; the smoke test above is the verification.

## Conventions & guardrails

- Tags follow `<YEAR>-<N>` (e.g. `2025-1`), plus `latest`.
- **Do not push images** (`docker bake --push`, `docker push`) or log in to Docker Hub unless the
  user explicitly asks — publishing is outward-facing.
- Keep the image minimal; Alpine + Temurin 8 JRE. Don't bump Java major version without checking
  LVG compatibility.
- `sha1sum -c` requires the checksum file format `<sha1><two spaces><filename>`; preserve it.
- Commit messages are short and imperative-ish, e.g. `Updated to lvg 2025 and added docker bake file`.
