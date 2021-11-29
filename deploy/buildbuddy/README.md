# Buildbuddy deployment

## Prerequisites

* Functional k8s cluster (1.18 to 1.21) with valid credentials.
* kubectl and helm3.
* Ownership of a domain and ability to create A records.
* Ability to create GCS service account (Storage Admin on GCP).
* Valid credentials (key) for the GCS service account.
* Valid oauth2 client ID and secret if enabling authentication/SSO.
* Valid ouath2 credentials for SCM integration.

## Configuration

We use the BuilBuddy Enterprise helm chart to install the application. 

The example values file enables:

* Prebaked components:
    * Built in mysql DB for invocations and UI.
    * Cert-manager for TLS certificates.
    * Ingress configuration for HTTPS and GRPCS endpoints.
    * Ingress controller.
    * Promethesus and grafana
* Three node executor pool (using default executor container)

## Installation

1. Update the values file to suit your needs.

2. Add the Build Buddy helm repo

`helm repo add buildbuddy https://helm.buildbuddy.io`

3. Install chart using values. 

```
helm upgrade -i buildbuddy buildbuddy/buildbuddy-enterprise \
    --version=0.0.102 \
    --namespace=buildbuddy \
    -f buildbuddy-values.yaml
```

## Post install steps

If configuring DNS, certmanager and Ingress, you will need to update your A records (fe.g. buildbuddy.build.exmaple.com and grpc.build.examples.com) to the ingress controller as owned by Build buddy.

You can obtain this address by running the following command, and using the IP address in the `EXTERNAL-IP` column as the IP address for your A records.

```
✗ kubectl get svc buildbuddy-ingress-controller
NAME                            TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
buildbuddy-ingress-controller   LoadBalancer   10.40.15.143   35.204.aaa.bbb   80:30227/TCP,443:31053/TCP   10d
✗
```

The build buddy cert manager deployment uses the [HTTP01 solver](https://cert-manager.io/docs/configuration/acme/http01/), so your system will not be available until the a records are configured, and the challenge is solved.