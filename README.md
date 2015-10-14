# docker-play
Docker image that automatically starts a play server from a packaged app.


# How to use
docker run --rm 
-v /path/to/app/dir/:/play/app/:z
-v /path/to/app.zip:/play/app.zip:z
-v /path/to/repo.txt:/play/repo.txt:z 
-v /path/to/configuration/file.conf:/play/config.conf:z
gbecan/play
