=====
Tests
=====

List of tests we want to have

Spell Check
===========

- Checks spelling

Link Check
==========

- Checks if links are working

Line Length
===========

- Checks length of lines, around 100 words, done by :doc:`testrunner/rd-coala`


Article Length
==============

- Checks the length of articles, to make sure there are not too long, done by :doc:`testrunner/rd-coala`

reST Lint
=========

- Checks if reST is valid

English Prose
=============

- Checks for passive voice
- Checks for lexical illusions – cases where a word is repeated
- Checks for so at the beginning of the sentence
- Checks for there is or there are at the beginning of the sentence
- Checks for "weasel words"
- Checks for adverbs that can weaken meaning: really, very, extremely, etc.
- Checks for wordy phrases and unnecessary words
- Checks for common cliches

Space Consistency
=================

- Checks to avoid mix between spaces and tabs, done by :doc:`testrunner/rd-coala`

Sphinx Lint
===========

- Checks if ``sphinx build`` works in picky mode, done by :doc:`testrunner/rd-sphinx`

To Do
------

- write docs about testrunner.sphinx, explain the difference to mr.docs
- add function to run testrunner.sphinx in ci or local mode, where the difference is hiding and saving output

Word Consistency
================

- Checks for consistence use of words, like GitHub, **not** Github, :doc:`testrunner/rd-lint`

To Do
------

- create docker container for ttd-lint, the test one is already working
- improve logging of script, besides showing save output to log, next to log from testrunner.sphinx
