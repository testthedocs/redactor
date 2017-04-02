Our custom clone/fork of coala

CI Syntax
=========

docker run -it --rm --entrypoint coala -v "${PWD}":/source:rw otest '-c=/source/.coafile' --non-interactive DOCS

.. note::

   Replace otest with the real container name
