# Demo Puppet implementation

This repo contains a demonstration of a simple IBM Integration Bus (IIB) installation installation. At this point in time our IIB modules are not released yet. To check how this repo works, please contact [Enterprise Modules](email:info@enterprisemodules.com) to get access to the private repositories containing our IIB modules.

## Requirements

Because this vagrant box uses private repo's inside of the box, you will have to have an ssh agent running on your host. See the Internet on how to do this for your specific host OS.

## Starting the nodes masterless

All nodes are available to test with Puppet masterless. To do so, add `ml-` for the name when using vagrant:

```
$ vagrant up ml-iib01
```

## Required software

The software must be placed in in the `software` directory. It must contain the next files:

### IBM MQ
- 10.0.0-IIB-LINUXX64-FP0008.tar.gz

# Example run

Check here the example run:

[![asciicast](https://asciinema.org/a/109018.png)](https://asciinema.org/a/109018)
