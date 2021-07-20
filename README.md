# hostname

An utility block to set the hostname of devices running balenaOS.

**Disclaimer**: Setting the hostname on a device running balenaOS is as easy as hitting an API endpoint on the supervisor. This utility wraps the required http request into a prebuilt image that you can drop on your projects. It's clearly *NOT* the most efficient approach as the device needs to download and run an additional container. See our [documentation](https://www.balena.io/docs/reference/supervisor/supervisor-api/#patch-v1devicehost-config) for specifics on how to roll this into your own services.


## Usage

TODO