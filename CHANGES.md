# Changelog

## 2026-06-22

- Add Python 3.14 runtime image (`ghcr.io/wongcht/lambda-gdal:{gdal_version}-python3.14`), now the default in docs and examples
- CI: build/deploy steps use Python 3.14 to run scripts/deploy.py and scripts/list.py

## 2026-06-17

- Update to GDAL 3.13.1

## 2026-02-23

- Update to GDAL 3.12.2
- Support Amazon Linux 2023 only. Drop Amazon Linux 2 as its end of life is soon (2026-06-30)
- Support Python 3.12, 3.13. Drop Python 3.9, 3.10, 3.11
- Update `Dockerfile`
  - Replace Amazon Linux 2 image with Amazon Linux 2023
  - `dnf` replaces `yum`
  - Install libtirpc-devel, libicu-devel, perl, libtirpc
  - Uninstall cmake from dnf because hdf5 requires cmake 3.26 or above, which is not available in dnf. Install individually instead
  - Dependencies:
    - CMake: 4.2.3 replaces cmake v3 in Linux
    - sqlite: 3.51.2
    - libexpat: 2.7.4
    - libxml2: 2.15.1
    - nghttp2: 1.68.0
    - libcurl: 8.18.0
    - libdeflate: 1.25
    - libpng: 1.6.55
    - libjpeg_turbo: 3.1.3
    - webp: 1.6.0
    - zstd: 1.5.7
    - lerc: 4.0.0
    - libtiff: 4.7.1
    - postgres: 18.2
    - openjpeg: 2.5.4
    - geos: 3.14.1
    - proj: 9.7.1
    - libgeotiff: 1.7.4
    - blosc: replaced with blosc2 2.23.0
    - cryptopp: 8.9.0
    - hdf4: 4.3.1
    - hdf5: 2.0.0
    - Add libaec 1.1.3 for hdf5 2.0.0+
    - Add brotli 1.2.0
    - patchelf: 0.18.0
  - Fix warning inside, e.g. use `=` in `ENV`
- Python runtime
  - update C to c11
  - install openblas-devel, lapack-devel, pkgconfig
  - update numpy to 2.4.2
- Update AWS Lambda layer runtimes which are compatible with Amazon Linux 2023 only
  - support node 24, python 3.14, java 25, dotnet10, ruby 3.4
  - drop node 18, python 3.9 3.10 3.11, java 8 11 17, dotnet 6, ruby 3.2, provided.al2
- GitHub Actions CI:
  - could be triggered manually
  - update Actions used
    - actions/checkout@v6
    - actions/setup-python@v6
    - actions/setup-node@v6
    - aws-actions/configure-aws-credentials@v6  

- changes from upstream repository:
  - Add support for Python 3.12 and 3.13
  - Update deploy.py script compatible runtimes list to currently-available runtimes

## 2024-02-02.patch1

- no change (fixing CI)

## 2024-02-02

- update versions (author @philvarner, https://github.com/lambgeo/docker-lambda/pull/76):
  - GDAL: 3.8.3
  - GEOS: 3.12.1
  - PROJ: 9.3.1

- fix `libsqlite3` lib links (author @jasongi, https://github.com/lambgeo/docker-lambda/pull/75)

## 2023-12-20

- update to GDAL 3.8.2

## 2023-11-28

- add `yum update` and `yum clean all` to base image (author @philvarner, https://github.com/lambgeo/docker-lambda/pull/64)
- update to GDAL 3.8.0 (author @philvarner, https://github.com/lambgeo/docker-lambda/pull/65)

## 2023-10-23

- update Python 3.11 base image (author @philvarner, https://github.com/lambgeo/docker-lambda/pull/60)
