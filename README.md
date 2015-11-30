# How to use this overlay

[Local overlays](https://wiki.gentoo.org/wiki/Overlay/Local_overlay) should be managed via `/etc/portage/repos.conf/`.
To enable this overlay make sure you are using a recent Portage version (at least `2.2.14`), and create an `/etc/portage/repos.conf/ring-overlay.conf` file containing precisely:

```
[ring-overlay]
location = /usr/local/portage/ring-overlay
sync-type = git
sync-uri = https://github.com/stefan-langenmaier/ring-overlay.git
priority=9999
```

Afterwards, simply run `emerge --sync`, and Portage should seamlessly make all our ebuilds available.
