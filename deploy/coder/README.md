# Coder deployment

## Prerequisites

* Functional k8s cluster (1.18 to 1.21) with valid credentials.
* kubectl and helm3.
* Ownership of a domain and ability to create A records.
* A Coder license key (60 day trial here - https://coder.com/trial)

Either:

* Manually obtained TLS sercrets OR
* a functioning cert-manager installation.

## Configuration

The default coder values have only had two changes made.

1. Update tge `coderd.devurlsHost` key, where we are required to update the domain name where coder will live.
2. Update the `coderd.tls.{devurlsHostSecretName,hostSecretName}` keys to point at a secret used for certficiates.

In this example, we used cert-manager (and the DNS01 solver), to obtain valid certificates for our domain.

### Cert-manager

1. Install cert-manager

```
helm install \                                                                       
  cert-manager jetstack/cert-manager \                              
  --namespace cert-manager \
  --create-namespace \
  --version v1.5.4 \
  --set installCRDs=true
```

2. Install cluster issuer (in this case, using [DNS01 solver](https://cert-manager.io/docs/configuration/acme/dns01/google/)).

`kubectl apply -f clusterissuer.yaml`

3. Install the certificate request

`kubectl apply -f coder-certs.yaml`

## Installation

1. Update the values file to suit your needs.

2. Create the TLS secrets, referenced in your Coder values.

3. Install chart using the checked in tarball and your values. 

```
helm upgrade -i coder coder-1.24.0.tgz \
    --namespace coder \
    --create-namesapce \
    -f coder-values.yaml
```

## Post install

Unlike Build Buddy, Coder does not allow for integration configuration via deployment manifest. Configuring integrations for SSO, SCM etc require Day 0 tasks, which must be completed via the UI.

You can read more about these tasks in thr [Admin](https://coder.com/docs/coder/latest/admin) section of the Coder docs.