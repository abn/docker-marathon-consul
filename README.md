# Marathon Consul Container

This project puts [Marathon Consul](https://github.com/CiscoCloud/marathon-consul) in scratch docker container. It is available on [Docker Hub](https://registry.hub.docker.com/u/alectolytic/marathon-consul/) and can be pulled using the following command.

```sh
docker pull alectolytic/marathon-consul
```

You will note that this is a tiny image.
```
$ docker images | grep docker.io/alectolytic/marathon-consul
docker.io/alectolytic/marathon-consul  latest  0656e0467edc  About an hour ago  4.717 MB
```

## Quickstart

```sh
docker run --rm -it -v /etc/ssl/certs:/etc/ssl/certs:ro alectolytic/marathon-consul
```
