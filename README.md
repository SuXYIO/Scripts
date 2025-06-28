# Scripts

## Intro

A repo where I store some of my **scripts**.  
Most of them are rough, some might be useful.

## Items

### pinglen

Request a `GET` for a certain `URL`, and iterate through a range of params, analyzes the return length and find interesting values.  
A pretty useful tool for `web CTF`s (or at least I thought so). Not comparable with tools like `BurpSuite`.

Deps: `requests`, `tqdm`

### drawFunction

A slow tool for drawing 2D mathmatical function plots.  
Written using the `turtle` lib, so it's very _SLOW_.  
Written because I got bored.

Deps: None

### LuaWeather

Get the weather from `OpenWeatherAPI` (requires API key).  
Was formally made to integrate into `NeoVim`, but I failed.

Deps: `dkjson`

### ersa

Easy `RSA` (maybe not that easy).  
A interactive scipt for basic `RSA` operations like _Keygen_, _Encryption_, _Decryption_.  
Was formally made to pass secret messages with a friend, who is not very good at the computer, but again, I failed.

Deps: `OpenSSL`

### arpsniff.cap

A script performing _Arpsniff_ for [Bettercap](https://github.com/bettercap/bettercap).  
Yeah, I made it because I keep forgetting commands. And I've been without `Bettercap` for a while now.

Deps: `Bettercap`

### Benford

A script to check and plots the first digit distro for a CSV data's numbers.  
use `python3 benford.py -h` for help

### githost

A oneline script to change `/etc/hosts` from [tinsfox github hosts](https://github-hosts.tinsfox.com/) source.  
Better used with `crontab` to set it as a routine.  
Really thankful to tinsfox authors!
