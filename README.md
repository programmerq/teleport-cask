# Instructions

Set up the tap:

```
$ brew tap programmerq/tc https://github.com/programmerq/teleport-cask.git
```

Install the cask:

```
$ brew install --cask teleport-ent
```

There are three casks available: `teleport`, `teleport-ent`, `tsh`. They all install the .pkg installer provided by teleport.

There are also `teleport-ent@XX.0` casks for the major versions that aren't the latest.

# Caveats

This repo was an experiment and is not currently updated automatically with
releases.

# Updating the casks

There is a GitHub action that runs daily at midnight UTC and runs [update.sh](./update.sh) to update the casks.
