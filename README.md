# Share Playstate on older LG webOS TVs

This mod enables sharing the playstate on older LG webOS versions by exposing the [`com.webos.media/getForegroundAppInfo` API](https://www.webosose.org/docs/reference/ls2-api/com-webos-media/#getforegroundappinfo) via the secondscreen gateway running on TCP port 3000.
For example, so that the [Home Assistant integration for LG webOS TV](https://www.home-assistant.io/integrations/webostv) can access it.

This was tested with the following webOS versions:

* 6.5.1 (LG OLED C1 firmware version 03.52.50)

Newer webOS versions (I think starting with webOS 7) expose this API by default and, therefore, do not need this mod.

## Installation

It requires that you rooted your TV and have SSH enabled.
See <https://www.webosbrew.org/rooting/>.

Clone the repository and upload it on your TV:

```sh
git clone https://github.com/lxp/webos-share-playstate
rsync -rEtv webos-share-playstate root@<your TV IP address>:
```

Then connect to your TV via SSH (i.e. `ssh root@<your TV IP address>`) and finalize the installation:

```sh
mkdir -p /var/lib/webosbrew/init.d
ln -sf /home/root/webos-share-playstate/share-playstate.sh /var/lib/webosbrew/init.d/10-share-playstate
```

## Uninstallation

Connect to your TV via SSH and do the following steps:

```sh
rm /var/lib/webosbrew/init.d/10-share-playstate
rm -r /home/root/webos-share-playstate
```
