# jenkins


### build jenkins master container

```
$ docker build -t jenkins-master -f jenkins-master.dockerfile ./jenkins

```

### Run jenkins

```
$ docker run --name jenkins-master -p8080:8080 -d -v /var/run/docker.sock:/var/run/docker.sock  -v /usr/bin/terraform:/usr/bin/terraform jenkins-master

```


### Docker exec jenkins-master
to setup .ssh/config

```
$ docker exec -it jenkins-master bash 

echo '
Host bastion
        HostName 34.229.156.109
        StrictHostKeyChecking no
        IdentityFile /root/.ssh/pk.pem
        User ubuntu

Host application
        HostName 10.0.2.29     
        StrictHostKeyChecking no
        IdentityFile /root/.ssh/pk.pem
        Port 22
        User ubuntu     
        ProxyCommand ssh -q -W %h:%p bastion
' 
> /root/.ssh/config

```

### cp private key to jenkins-master

```
docker cp pk.pem jenkins-master:/root/.ssh/pk.pem

```
