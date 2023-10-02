# yarr

[![GitHub Synchronization Status](https://img.shields.io/github/actions/workflow/status/wakeful-cloud/yarr/sync.yml?label=Synchronization&style=flat-square)](https://github.com/wakeful-cloud/yarr/actions/workflows/sync.yml)
[![GitHub Build Status](https://img.shields.io/github/actions/workflow/status/wakeful-cloud/yarr/build.yml?label=Build&style=flat-square)](https://github.com/wakeful-cloud/yarr/actions/workflows/build.yml)

Fork of [Nazar Kanaev's yarr](https://github.com/nkanaev/yarr) that auto-synchronizes with upstream and
auto-builds Docker images (See [#20](https://github.com/nkanaev/yarr/issues/20)).

## Documentation

### Running
```bash
# Run in foreground
docker run -it -v [Absolute path on host to store data]:/data -p 7070:7070/tcp --name yarr ghcr.io/wakeful-cloud/yarr:latest

# OR run in background
docker run -d -v [Absolute path on host to store data]:/data -p 7070:7070/tcp --name yarr ghcr.io/wakeful-cloud/yarr:latest
```
*Note: for improved security and stability, you should use specific commit tags instead of `latest`.*

### Environment Variables
Name | Required/Default | Description
--- | --- | ---
`UID` | `1000` | Runner user ID
`GID` | `1000` | Runner group ID
`ADDRESS` | `0.0.0.0` | Listening address
`PORT` | `7070` | Listening port
`DATA` | `/data` | Data directory

## FAQ

### What are the differences between this fork and upstream?
This fork uses a custom, more-secure, more-flexible [Dockerfile](Dockerfile) than upstream. Beyond
that, this fork adds the [GitHub actions](.github/workflows) required for automatic synchronization
and building.

### What architectures are supported?
* X86 64-bit (`linux/amd64`)
* Arm V6 32-bit (`linux/arm/v6`)
* Arm V7 32-bit (`linux/arm/v7`)
* Arm V8 64-bit (`linux/arm64/v8`)
