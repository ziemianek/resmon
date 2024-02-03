# Build stage
FROM alpine:3.14 as Builder

# Perform updates
RUN apk update && \
    apk upgrade

# Install build dependencies
RUN apk add \
    gcc \
    git

# Display versions for verification
RUN gcc --version && \
    git --version

# Second stage: Runtime stage
FROM alpine:3.14 as Final

# Copy only the necessary artifacts from the build stage
COPY --from=Builder /usr/bin/gcc /usr/bin/
COPY --from=Builder /usr/bin/git /usr/bin/
