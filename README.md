# hostname

An utility block to set the hostname of devices running balenaOS.

**Disclaimer**: Setting the hostname on a device running balenaOS is as easy as hitting an API endpoint on the supervisor. This utility wraps the required http request into a prebuilt image that you can drop on your projects. It's clearly *NOT* the most efficient approach as the device needs to download and run an additional container. See our [documentation](https://www.balena.io/docs/reference/supervisor/supervisor-api/#patch-v1devicehost-config) for specifics on how to roll this into your own services.


## Usage

To use this image, create a container in your `docker-compose.yml` file and set the `SET_HOSTNAME` environment variable as shown below:

```yaml
version: '2'

services:

  hostname:
    build: .
    restart: no                               # Required to avoid container restarting indefinitely
    labels:
      io.balena.features.supervisor-api: 1    # Required to interact with the supervisor
    environment:
      SET_HOSTNAME: balena-test-hostname
```