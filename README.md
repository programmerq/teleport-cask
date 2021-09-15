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

# Caveats

This repo was an experiment and is not currently updated automatically with
releases.

# Updating the casks

When a new release comes out, update the version string in each Cask file, and the corresponding sha256 digest for each file.
