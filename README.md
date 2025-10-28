# Docker Build Environment

## Overview

This Debian-based Docker image provides a complete development and build environment for modern full-stack applications. It comes pre-configured with Node.js, OpenJDK, and Gradle, all managed through [asdf](https://asdf-vm.com/) version manager for flexible version control.

## Features

- **Base OS:** Debian (stable)
- **Version Manager:** asdf for unified tool version management
- **Installed Tools:**
  - Node.js - JavaScript runtime for Vue.js 3 development
  - OpenJDK - Open-source Java runtime for Spring Boot applications
  - Gradle - Build automation tool for Java projects
- **Auto-Updates:** 
  - Image is automatically rebuilt every 15 days
  - Always includes the latest versions of Node.js, OpenJDK, and Gradle
  - Ensures up-to-date security patches and features

## Use Cases

This image is designed for building:
- **Frontend:** Vue.js 3 applications
- **Backend:** Spring Boot 5.x services
- **Full-stack:** Combined frontend and backend builds in CI/CD pipelines

## Quick Start
```bash
docker pull ghcr.io/henriquenizolli/debian-builder:latest
docker run -it ghcr.io/henriquenizolli/debian-builder:latest
```

## Update Schedule

This image is automatically rebuilt every 15 days to ensure:
- Latest stable versions of Node.js, OpenJDK, and Gradle
- Most recent Debian security updates
- Bug fixes and performance improvements

Always pull the latest image before building to benefit from the most recent updates.