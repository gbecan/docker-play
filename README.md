# docker-play
Docker image that automatically starts a play server from a packaged app or a git repository.


# How to use

## From a zip
**Prerequisite: the zip must be created with activator dist**
```
docker run -v /path/to/app.zip:/play/app.zip:z gbecan/play
```

## From a git repository
**Prerequisite: activator must be present in the repository**

Specify the url to the git repository in a file and start the container as following:
```
docker run -v /path/to/repo.txt:/play/repo.txt:z
```

## Configuration file
If you need to provide a configuration file for the server, you can add the following option to ```docker run```:
```
-v /path/to/configuration/file.conf:/play/config.conf:z
```
