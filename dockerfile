# Builder
FROM golang:1.18.3-alpine3.16 AS builder

# Set the working directory
WORKDIR /src

# Install packages
RUN apk add --no-cache build-base git

# Add the source code
COPY . .

# Build for the current platform
RUN make build_default

# Runner
FROM alpine:3.16

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