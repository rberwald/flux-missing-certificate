# flux-tf-state-unlocker

Unlock the Terraform state that the Flux Terraform controller tries to use.

## Problem

When running Terraform code to control the Kubernetes cluster that the Flux Terraform controller is running on, it can happen that the Runner is terminated. This happens among others when the node that the Runner runs on, is upgraded, and the node is evacuated. The Runner is then moved to a different node, but the Terraform run is stopped without freeing up the Terraform lock.

## Solution

The script looks at the state of a Terraform resource of the Terraform controller. When a certain condition exists, the script patches the Terraform resource definition to automatically unlock the Terraform state at the start of the run.