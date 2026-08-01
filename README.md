# MapFiles
Applies a command/script to each file in a folder


## Installation
After cloning the repo or getting map.hs in your computer, you just need to compile it with

```console
$ ghc map.hs
```

This will create
```console
map.o
map.hi
map
```
files. You only need to keep map.

## Usage
You can use it on every file in a path:

```console
$ ./map <cmd> <dir>
```

for example:
```console
$ ./map "ls -l" "./Downloads"
```


You can also specify a file extension so that it only maps the command to files with a specific extension:

```console
$ ./map <cmd> <dir> <extension>
```

for example:
```console
$ ./map "ormolu" "./MapFiles" ".hs"
```

or:
```console
$ ./map ormolu ./MapFiles .hs
```
also works! I would recommend passing them with "" just to be sure, though :3

For any of these you should make sure that the command works on the files it will be applied to.
The path can be relative or absolute. Using "~" as "/home/user/" doesn't work.