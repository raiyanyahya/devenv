
![Alt text](https://i.ibb.co/zQ05SGX/devenv.png "devenv")
# devenv
A Freshenv developer desktop in a docker image. It gets quite tricky to manage multiple projects on your on pc, projects tend to gather in the disk and it gets hard to manage system wide dependencies. This docker image comes pre-installed with the most common developer tools and can easily be destroyed and used fresh. You can also attach your local ssh config to access your git accounts. The image also has Gitpod's opensource vscode server and its super easy to mount your project directory and start programming directly in the browser.
Feel free in adding improvements. Pull Requests are very much welcome :)
Cheers!

### Usage

Run a fresh environment.
```
docker run --rm -it -p 3000:3000 -v ${PWD}:/home/devuser/  ghcr.io/raiyanyahya/devenv/devenv
```

Run a fresh environment in --privileged mode to enable docker in docker. Also attach the docker.sock to the container.
```
docker run --rm -it -p 3000:3000 -v ${PWD}:/home/devuser/ --privileged -v "/var/run/docker.sock:/var/run/docker.sock" imageid
```

Starting the vscode server in the background. The server is exposed on port 3000.
```
upcode
```

Stopping the vscode server
```
downcode
```

### URL for the vscode server
```
http://localhost:3000/?tkn=password123
```
