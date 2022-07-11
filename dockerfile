# Builder
FROM golang:1.18.3-alpine3.16 AS builder

# Set the directory
WORKDIR /src

# Install packages
RUN apk add --no-cache build-base git

# Add the source code
COPY . .

# Build for the current platform
RUN make build_default

# Runner
FROM alpine:3.16

# Create a user
RUN addgroup -S yarr
RUN adduser -S -h /home/yarr -H -G yarr yarr
WORKDIR /home/yarr

# Copy the build
COPY --chown=yarr:yarr --from=builder /src/_output/yarr .

# Install packages
RUN apk add --no-cache ca-certificates

# Update certificates
RUN update-ca-certificates

# Switch to the user
USER yarr

# Start the server
CMD ["/home/yarr/yarr", "-addr", "0.0.0.0:7070", "-db", "/data/yarr.db"]