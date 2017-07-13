======
Status
======

redactor is *work in progress* ! There is **no** working release, yet !

Currently it is a collection of various ideas about different tests and setups.

Challanges
==========

Usage should be as painless as possible.

This is tricky, for now we use too many different tools with own configurations, this has certain downtimes:

- confusing
- work intensive, since all of them need own configurations
- messing up the root dirs, since we place `.$CONFIG` there, too
- some test reports are complicated, like markdown lint 

Solutions
=========

Use sane defaults for reST, markdown and so on, include these into the images.

If people want to use their own, they can still place them into the root dir and with that overwrite the `default` settings.

IMHO, start with less ones and see how that goes.

Images
======

One vs many, not sure yet what the best approach is, maybe a compromise, meaning bundeling some but not all.

Reasons
-------

One huge image is slow to download

Many small images are labor intensive with maintaininig.
