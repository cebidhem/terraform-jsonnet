# terraform-gitlabci-jsonnet
This repo shows an example of how to dynamically generate GitLab CI child pipelines for Terraform using Jsonnet.

### Terraform files

This is a simple terraform layout describing 3 AWS environments (could be different accounts or not):
- organization
- staging
- production

In the `organization` module, we only have 1 workspace named `organization`.

For the `staging` module, we have 2 workspaces representing 2 different regions (`eu-west-1` and `eu-central-1`)

For the `production` module, we have 2 workspaces representing 2 different regions (`eu-west-1` and `eu-central-1`)

Our `main.tf` files are empty on purpose, the focus is not terraform here.

### Jsonnet files

Run `jsonnet gitlab-ci.jsonnet > generated-gitlab-ci.yml` in order to generate your child pipeline jobs.
