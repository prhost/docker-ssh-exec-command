#!/bin/bash

# host option
if [ -z "$SSHEXEC_HOST" ]
then
    echo 'ERROR - missing host (SSHEXEC_HOST) option'
    exit 1
fi

if [[ "$SSHEXEC_PRIVATE_KEY" == "" ]] ; then
  echo "private key is an empty string, please check (SSHEXEC_PRIVATE_KEY)"
  exit 1
fi

# host option
if [ -z "$SSHEXEC_SCRIPT" ]
then
    echo 'ERROR - missing host (SSHEXEC_SCRIPT) option'
    exit 1
fi

# user option
remote_user="root"
if [ -n "$SSHEXEC_USERNAME" ];
then
    remote_user="$SSHEXEC_USERNAME"
fi
echo "using user $remote_user"

# port option
remote_port="22"
if [ -n "$SSHEXEC_PORT" ]; # Check $SSHEXEC_PORT exists and is not empty
then
    remote_port="$SSHEXEC_PORT"
fi
echo "using remote port $remote_port"

#save public key
export SSHEXEC_ID_FILE=/tmp/id.key
echo -e "$SSHEXEC_PRIVATE_KEY" > "$SSHEXEC_ID_FILE"

#set permission
chmod 0700 "$SSHEXEC_ID_FILE"

export DEPLOY_SSH="ssh $SSHEXEC_HOST -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p $remote_port -l $remote_user -i $SSHEXEC_ID_FILE"

echo "Test connect $DEPLOY_SSH"

$DEPLOY_SSH echo 1 &> /dev/null || failed=true

if [ "$failed" == "true" ] ; then
  echo "Could not connect"
  $DEPLOY_SSH -v echo 1
  exit 1
fi


echo "Created DEPLOY_SHH $DEPLOY_SSH"

echo "$DEPLOY_SSH $SSHEXEC_SCRIPT"

$DEPLOY_SSH "($SSHEXEC_SCRIPT)"