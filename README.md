# SSH EXEC COMMAND

Run commands remotely via ssh.

[Docker Hub](https://hub.docker.com/r/prhost/ssh-exec-command/)


`docker pull prhost/ssh-exec-command`


`SSHEXEC_HOST` = host server (required)

`SSHEXEC_PRIVATE_KEY` = private sshkey access

`SSHEXEC_USERNAME` username (default user root)

`SSHEXEC_PORT` = (default port 22)

`SSHEXEC_SCRIPT` = shell command to be executed


```
docker run --rm \
	-e SSHEXEC_HOST=example.com \
	-e SSHEXEC_PRIVATE_KEY="$(< ~/.ssh/id_rsa.key)" \
	-e SSHEXEC_USERNAME=username \
	-e SSHEXEC_PORT=22 \
	-e SSHEXEC_SCRIPT="ls -la" \
prhost/ssh-exec
```