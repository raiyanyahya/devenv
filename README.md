# devenv
A developer desktop in a docker image.

## Usage

Run a fresh environment.
```
docker run --rm -it -p 3000:3000 -v ${PWD}:/home/devuser/  ghcr.io/raiyanyahya/devenv/devenv
```

## Manage the vscode server
start the server
```
upcode
```

stop the server
```
downcode
```

## URL for the vscode server
```
http://localhost:3000/?tkn=password123
```
