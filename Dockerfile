# Builder (See https://hub.docker.com/layers/library/alpine/3.24.1/images/sha256-6f5908cdf811d574b30ec394e405ef74ee293bed5af1620a5187d604604a90a8)
FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS builder

# Set the working directory
WORKDIR /src

# Install packages
RUN apk add --no-cache build-base git go nodejs npm

# Add the source code
COPY . .

# Install dependencies
RUN npm ci

# Build for the current platform
RUN make host

# Runner (See https://hub.docker.com/layers/library/alpine/3.24.1/images/sha256-6f5908cdf811d574b30ec394e405ef74ee293bed5af1620a5187d604604a90a8)
FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

# Set the working directory
WORKDIR /home/yarr

# Copy the build
COPY --from=builder /src/out/yarr .

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
