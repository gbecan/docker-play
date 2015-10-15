# docker-play
Docker image that automatically starts a play server from a packaged app or a git repository.


# How to use

## From a zip
**Prerequisite: the zip must be created with activator dist**
```
docker run -v /path/to/app.zip:/play/app.zip:z gbecan/play zip
```

## From a git repository
**Prerequisite: activator must be present in the repository**
```
docker run gbecan/play git https://mygitrepo.git
```

## Configuration file
If you need to provide a configuration file for the server, you can add the following option to ```docker run```:
```
-v /path/to/configuration/file.conf:/play/config.conf:z
```

## Options
If you want to provide additional options to the server, you can specify them in the ```docker run``` arguments. For example, you can set the port of the server as following:
```
docker run gbecan/play git https://mygitrepo.git -Dhttp.port=8080
```
