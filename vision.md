# Vision for redaktor beta release

The aim for the new beta release of redaktor is to create a tool that helps check text with a variery of best practise based tests. While the test configuration is opinionated, inquisitive users may change and override the defaults.

Initially, users run the tool locally, but in the future we plan a remote (maybe commercialised) service triggered by user actions such as a CLI command or GitHub push.

The tool is a wrapper that triggers tests that run in containers taken from our rackport repository, and those containers provide output. We aim to create a combined and unified output that processes those outputs into something more readable and provides an indication of the overall docs quality. In the future, the hosted service will also provide a badge and user friendly interface that shows these results.

For now, readaktor runs arbitrarily defined tests. Future versions will ask a user what tests they want to run. Further into the future we may consider GUIs for the configuration and output.

You can find other ideas [in our issue queue](https://github.com/testthedocs/redactor/issues).

## User spec

```
redactor init
```
init

testname
--help
--version
--format JSON|HTML
Runs and interactive setup process that lets you define tests, and container location, if you don't specify a different container, it writes the defauklt.

If I try to run any other command apart frome help and version without a config file, i am told I need to run `innit` first.

I can run `redactor mdlint` etc, in which case it still checks config file, but only reads contaier setting for that test.

`init` command
You have to mount a folder, and all contents including sub folders are mounted (needs security for 'sumb' folders). There is no path parameter, it runs in your current folder, we hope to make this possible, by using Homebrew, Choclately etc so that teh command is in PATH anyway.

The results of the tests are sent to another temporayr container (yet to be named) with a logspout containe (maybe), and that contanier takes the input, hopefully as JSON if possible, but if not, it converts what it receives to JSON.

It takes this JSON, processes, groups, sanitizes (exact yet to be defined), calculates overall scores and creates a new JSON file that is either served as HTML, or given back to the user depending on the format they specified (default HTML).
