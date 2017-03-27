=============
Configuration
=============

Use toml or yaml for a nice easy to read, understand and to update config file.

TOML
====

This example uses toml with jinja2

Dependencies
------------

- python2.7
- jinja2
- jinja2-cli

Install
-------

Do that in a virtualenv

.. code-block:: shell

   pip install jinja2-cli[toml]

Example Files
-------------

test.j2:

.. code-block:: shell

   #!/bin/bash

   echo {{ test.version }}

test.toml:

.. code-block:: shell

   [test]
   version = "1"

Usage
-----

Run jinja2-cli:

.. code-block:: shell

   jinja2 test.j2 test.toml > foo.sh

Created Script
--------------

.. code-block:: shell
   
   #!/bin/bash

   echo 1

.. note::

	jinja2-cli workd with yaml, too
