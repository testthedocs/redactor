==========
Motivation
==========

We want to improve the quality of `docs.plone.org <http://docs.plone.org/>`_.

Current
=======

The current situation is that we *do not* run real tests at all.

We have a basic test, which builds the docs with `Sphinx <http://www.sphinx-doc.org/en/stable/>`_ and tries to create
pictures with `robot framework <http://docs.plone.org/external/plone.app.robotframework/docs/source/>`_.


Future
======

The goal is to have a test framework, which is modular and flexible.

It should be possible to run this tests local and on CI.

