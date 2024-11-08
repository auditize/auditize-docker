# Docker Compose environment for Auditize

## Introduction

This repository contains a Docker Compose environment for [Auditize](https://www.auditize.org). In addition to the `web` and `scheduler` Auditize services, it also includes:

- a `mongo` service for the database,
- a [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy) and [acme-companion](https://github.com/nginx-proxy/acme-companion) services for reverse proxy and SSL certificate management.

This environment uses [acme-companion](https://github.com/nginx-proxy/acme-companion) to automatically generate SSL certificates using [Let's Encrypt](https://letsencrypt.org/). It means that you need to have a **public domain name** pointing to the server running this Docker Compose environment, and this domain name must be accessible on ports 80 and 443. Please check the
[acme-companion documentation](https://github.com/nginx-proxy/acme-companion) for more details.

This docker-compose environment will store all persisted data in subdirectories of the `volumes` directory.

**Beware** that it is a very basic way to deploy Auditize, and is not intended for production use as is.

## Usage

After cloning the repository and `cd` into it, you'll need to create two files:

- a `.env` file with the following content, replacing the placeholders with your own values:
  ```bash
  VIRTUAL_HOST=your.domain.name
  LETSENCRYPT_HOST=your.domain.name
  DEFAULT_EMAIL=your.email@address
  ```
- a `auditize.env` file with your [Auditize environment variables](https://www.auditize.org/config/)

Then you can start the environment with:

```bash
sudo docker compose up -d
```

We use `sudo` because the `nginx-proxy` service needs to bind to ports 80 and 443, which are privileged ports.

There are alternative ways to start the environment without using `sudo`, such as:

- binding non-privileged ports (8000 and 4443 for instance) in `docker-compose.yml` and making a network redirection from 80 and 443 to 8000 and 4443,
- or modifying the `net.ipv4.ip_unprivileged_port_start` Linux sysctl parameter to a value of `80` or lower.

Once the docker environment is up and running, you'll need to follow the post `docker compose up -d` instructions in the [Auditize installation guide](https://www.auditize.org/install/#docker-compose) regarding:

- MongoDB Replica Set initialization
- Auditize's first user bootstrap
