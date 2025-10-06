# Scripts

## Intro

A repo where I store some of my **scripts**.  
Most of them are rough, some might be useful.

## Items

### pinglen

Request a `GET` for a certain `URL`, and iterate through a range of params, analyzes the return length and find interesting values.  
A pretty useful tool for `web CTF`s (or at least I thought so). Not comparable with tools like `BurpSuite`.

Deps: `requests`, `tqdm`

### weather.lua

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

### githost

A oneline script to change `/etc/hosts` from [tinsfox github hosts](https://github-hosts.tinsfox.com/) source.  
Better used with `crontab` to set it as a routine.  
Really thankful to tinsfox authors!

### mylearn

Sometimes I see cool stuff online, and I try to write it myself, quick demos without much practical use.  
I'll put some here, the microprojects that is not very embarrassing to show.  
Also the projects before 25.10.03 is probably lost, except for `benford` and `drawFunction`.
