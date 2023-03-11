#!/bin/bash

if [ -s ./.env ]
then
	source ./.env
fi

if [ ! -f `which gcloud` ]
then
    echo "Could not find gcloud installed!"
    exit 1
fi

GKE_PROJECT_NM=$GKE_PROJECT

if [ -z $GKE_PROJECT_NM ]
then
	echo "GKE Project Name not set! Try 'export GKE_PROJECT=<my_project_name>'"
	exit 1
fi

SA_NAME=$1

if [ -z $SA_NAME ]
then
	echo "You must provide a Service Account name."
	echo "Usage: `basename $0` sa_name"
	exit 1
fi

SA_EMAIL=''

# Get SA_EMAIL
SA_EMAIL=`gcloud iam service-accounts list --format="csv(email)" | grep "$SA_NAME\@$GKE_PROJECT_NM"`

if [ -z $SA_EMAIL ]
then
	echo "Could not find an email for the service account"
	exit 1
fi

# Get the service account key
echo "Getting Service Account Key.json for $SA_NAME..."
gcloud iam service-accounts keys create $SA_NAME.key.json --iam-account=$SA_EMAIL

echo "Creating Base64 encoded version of the key..."
cat $SA_NAME.key.json | base64 > $SA_NAME.key.json.b64

echo "Done."
