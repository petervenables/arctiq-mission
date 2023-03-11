#!/bin/bash

if [ -s ./.env ]
then
	source ./.env
fi

GKE_PROJECT_NM=$GKE_PROJECT
SA_NAME=$1

if [ -z $GKE_PROJECT_NM ]
then
	echo "GKE Project Name not set! Try 'export GKE_PROJECT=<my_project_name>'"
	exit 1
fi

if [ -z $SA_NAME ]
then
	echo "You must provide a Service Account name."
	echo "Usage: `basename $0` sa_name"
	exit 1
fi

add_gke_role () {
	gcloud projects add-iam-policy-binding $GKE_PROJECT_NM \
	--member=serviceAccount:$SA_EMAIL \
	--role=roles/$1
}

echo "Creating Service Account with name $SA_NAME..."

EXISTS=`gcloud iam service-accounts list | grep -c "$SA_NAME\@$GKE_PROJECT_NM"`

if [ $EXISTS -eq 0 ]
then
	echo "Creating Service account with name $SA_NAME..."
	gcloud iam service-accounts create $SA_NAME
fi

SA_EMAIL=`gcloud iam service-accounts list --format="csv(email)" | grep "$SA_NAME\@$GKE_PROJECT_NM"`

if [ -z $SA_EMAIL ]
then
	echo "Could not find an email for the service account"
	exit 1
fi

echo "Email: $SA_EMAIL"
echo "Setting up permissions..."
add_gke_role(container.admin)
add_gke_role(storage.admin)
add_gke_role(container.clusterViewer)
echo "Done!"