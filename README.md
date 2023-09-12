# flux-missing-certificate

Restart the terraform controller when the secret for the runners is missing.

## Problem

When you try to delete the flux-system namespace, mess up, and recreate it, you could end up with two namespaces namef flux-system in etcd.
This problem is tracked in [this issue](https://github.com/weaveworks/tf-controller/issues/372).
The workaround is to restart the Terraform Controller.

## Solution

The script looks if the secret is present. If it is missing, the Terraform Controller is restarted, or stated differently: the pod is deleted and the stateful set will create a new one.