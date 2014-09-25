# [h5bp Apache Server Docker Image](https://github.com/patrickkettner/h5bp-docker-apache-server.git)

__h5bp Apache Server Docker Image__ is a base Dockerfile that allows you to build an
Apache server for your own app with the best practices in mind.

## Usage

You can download the image from the [docker hub](https://hub.docker.com)

```sh
docker pull patrickkettner/h5bp-server-configs-apache
```

or build the included Dockerfile from within the project

```sh
docker build -t patrickkettner/h5bp-server-configs-apache .
```

## Starting the container

```sh
docker run -d -p 49000:80 patrickkettner/h5bp-server-configs-apache
```

Where `49000` is the local port, and `80` is the port apache is listening on


## Connecting to the container

Docker only runs on linux, and as a result, if you want to run this on OS X or
Windows, you will need to virtualize a linux host. That additional level of
indirection breaks port forwarding.

boot2docker [suggests using VMWare's port mapping feature](https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md#port-forwarding-on-steroids) to fix this

With the virtual machine installed and stopped, you can run the following

```sh
for i in {49000..49900}; do
  VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
  VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
done
```

to forward the VMs ports 49000 to 49900 to the same port on localhost.

In order to reverse this change, simply run

``` sh
for i in {49000..49900}; do
  VBoxManage modifyvm "boot2docker-vm" --natpf1 delete "tcp-port$i";
  VBoxManage modifyvm "boot2docker-vm" --natpf1 delete "udp-port$i";
done
```


For more detailed information on configuration files, see the [h5bp apache
documentation](https://github.com/h5bp/server-configs-apache)

## License

[h5bp Apache Server Docker Image](https://github.com/patrickkettner/h5bp-docker-apache-server.git) is
available under the [MIT](LICENSE.md) license.
