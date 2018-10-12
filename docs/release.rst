=======
Release
=======

.. admonition:: About

    How to make a new release.

We use a combination of `gox <https://github.com/mitchellh/gox/>`_ and `ghr <https://github.com/tcnksm/ghr/>`_.

As soon as `GoReleaser <https://goreleaser.com/>`_ supports dynamic ``ldflags`` better we will switch to it.

How To Cut A New Release
========================

- Make sure the *feature branch* is ready (docs, changelog, version, install.sh, code)
- Merge *feature branch* into *master*
- Tag *master* with version/release number
- Run ``make build``
- Export GitHub token ``export GITHUB_TOKEN=abc123``
- Run ``ghr`` with version/release number ans path to packages: ``ghr 0.0.1 dist``

Check ``ghr`` for more possible options.

- Login to GitHub and make sure the release is there and that we have a nice changelog.
