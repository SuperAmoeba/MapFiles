# MapFiles
Applies a command/script to each file in a folder


## Installation
Download the compiled binary from the Releases tab or compile it from source yourself!

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
also works! :3

For any of these you should make sure that the command works on the files it will be applied to.
