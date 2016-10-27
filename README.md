# How to use this overlay

## with local overlays

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


## with layman

Invoke the following:

	layman -f -a ring-overlay
	
Or read the instructions on the [Gentoo Wiki](http://wiki.gentoo.org/wiki/Layman#Adding_custom_overlays).

# Installation

After performing those steps, the following should work:

	sudo emerge -av net-voip/gnome-ring

## _live_ vs _stable_ ebuild

There are two kind of ebuilds available. The _live_ ebuilds (with version 9999) are taken directly from the git master branch (and in case of the ring-daemon are compiled with the bundled libraries). The _stable_ ebuilds are from fixed versions and have been tested to work together. As a bonus they try to unbundle the application as much as possible.
