# Builder
FROM golang:1.24.3-alpine3.20 AS builder

# Set the working directory
WORKDIR /src

# Install packages
RUN apk add --no-cache build-base git

# Add the source code
COPY . .

# Build for the current platform
RUN make host

# Runner
FROM alpine:3.22

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
