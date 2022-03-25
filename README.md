# hostname

An utility block to set the hostname of devices running balenaOS.

**Disclaimer**: Setting the hostname on a device running balenaOS is as easy as hitting an API endpoint on the supervisor. This utility wraps the required http request into a prebuilt image that you can drop on your projects. It's clearly *NOT* the most efficient approach as the device needs to download and run an additional container. See our [documentation](https://www.balena.io/docs/reference/supervisor/supervisor-api/#patch-v1devicehost-config) for specifics on how to roll this into your own services.


## Usage

#### Prebuilt images

We maintain images for this block on balenaHub Container Registry. The images can be accessed using:

`bh.cr/g_tomas_migone1/hostname-<arch>` or `bhcr.io/g_tomas_migone1/hostname-<arch>` where `<arch>` is one of: `rpi`, `armv7hf`, `aarch64` or `amd64`.

For details on how to select a specific version or commit version of the image see our [documentation](https://github.com/balena-io/open-balena-registry-proxy/#usage).

#### docker-compose file
To use this image, create a container in your `docker-compose.yml` file and set the `SET_HOSTNAME` environment variable as shown below:

```yaml
version: '2'

services:

  hostname:
    image: bh.cr/g_tomas_migone1/hostname
    restart: no                               # Required to avoid container restarting indefinitely
    labels:
      io.balena.features.supervisor-api: 1    # Required to interact with the supervisor
    environment:
      SET_HOSTNAME: balena-test-hostname
```