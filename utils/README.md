# Utils

These utilities can help do some mundane/tedious tasks.

## Contents

- make_svc_acct.sh: Make a Google Cloud Service Account for your GKE project.



## Setup

You can provide configurable details about your project in a .env file. Define the following variables ahead of time:

```
GKE_PROJECT=your_gke_project_name
```

Aleternatively, simply export GKE_PROJECT to your env.

```
export GKE_PROJECT=your_gke_project_name
```

## Making a GKE Service Account

with GKE_PROJECT defined in either your env or .env, run the script:

```
$ make_svc_acct.sh svc_acct_name
```
