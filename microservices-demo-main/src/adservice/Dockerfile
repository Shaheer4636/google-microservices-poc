
# FROM eclipse-temurin:21@sha256:0ec8616e48cc54bffbabad6e6d4d221b486cb7afcff0b351fc30676a426e4db7 AS builder

# WORKDIR /app

# COPY ["build.gradle", "gradlew", "./"]
# COPY gradle gradle
# RUN chmod +x gradlew
# RUN ./gradlew downloadRepos

# COPY . .
# RUN chmod +x gradlew
# RUN ./gradlew installDist

# FROM eclipse-temurin:21.0.4_7-jre-alpine@sha256:8cc1202a100e72f6e91bf05ab274b373a5def789ab6d9e3e293a61236662ac27


# WORKDIR /app
# COPY --from=builder /app .

# EXPOSE 9555
# ENTRYPOINT ["/app/build/install/hipstershop/bin/AdService"]

##############################################################################
# Stage 1: Build
FROM eclipse-temurin:21 AS builder

WORKDIR /app

# Copy build.gradle, gradlew, and settings.gradle from adservice
COPY ./src/adservice/build.gradle ./src/adservice/gradlew ./src/adservice/settings.gradle ./

# Copy gradle directory from the project root (higher up in the file tree)
COPY ../gradle ./gradle

# Make gradlew executable and download repositories
RUN chmod +x gradlew
RUN ./gradlew downloadRepos

# Copy the rest of the adservice files
COPY ./src/adservice .  # Copy all adservice contents

# Build the application
RUN chmod +x gradlew
RUN ./gradlew installDist

# Stage 2: Create a smaller runtime image
FROM eclipse-temurin:21.0.4_7-jre-alpine

WORKDIR /app

# Copy the built application from the first stage
COPY --from=builder /app/build/install/hipstershop/bin/AdService .

# Expose the service port
EXPOSE 9555

# Run the application
ENTRYPOINT ["/app/AdService"]
