---
title: "About"
date: 2018-08-29T17:43:32+02:00
weight: 10
menu: true
draft: true
---

## Vision

The aim of Redactor is to be a tool that helps check text with a variety of best practice based tests.

While the test configuration is opinionated, inquisitive users may change and override the defaults.

Initially, users run the tool locally, in the future we plan a remote (maybe commercialized) service triggered by user actions such as a CLI command or Git push.

The tool is a wrapper that triggers tests that run in containers taken from [rackpart](https://rakpart.testthedocs.org), and those containers generate output.

We aim to create a combined and unified output that processes those outputs into something more readable and provides an indication of the docs quality.


For now, redactor runs arbitrarily defined tests.
Future versions will ask a user what tests they want to run.

Further into the future we may consider GUIs for the configuration and output.

You can find other ideas [in our issue queue](https://github.com/testthedocs/redactor/issues).

## User Spec

`redactor [command] [options]`

Redactor runs in your current folder, there is no `--path` parameter.
This mounts the folder into each container, including all subfolders.
Each test only handles the file types relevant to the test.

Redactor sends the results of the tests to a temporary container.

That container takes the input, as JSON if possible, but if not, it converts what it receives to JSON.

The container takes this JSON, processes, groups, sanitizes (to be defined), calculates rating and creates a new JSON file.

The container then serves that JSON as HTML, or returned to the user depending on the `--format` they specified.