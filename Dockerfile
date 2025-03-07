# Builder
FROM golang:1.24.0-alpine3.20 AS builder

# Set the working directory
WORKDIR /src

# Install packages
RUN apk add --no-cache build-base git

# Add the source code
COPY . .

# Build for the current platform
RUN (export GOARCH="$(go env GOARCH)" && export GOOS="$(go env GOOS)" && export CGO_CFLAGS="-D_LARGEFILE64_SOURCE" && make build_default)

# Runner
FROM alpine:3.21

# Set the working directory
WORKDIR /home/yarr

# Copy the build
COPY --from=builder /src/_output/yarr .

# Copy the entrypoint
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Install packages
RUN apk add --no-cache ca-certificates su-exec

# Update certificates
RUN update-ca-certificates

# Start the entrypoint
CMD ["/home/yarr/entrypoint.sh"]

EXPOSE 7070/tcp
