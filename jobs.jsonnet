{
  plan(cloud, env, workspace):: {
    image: {
      name: 'hashicorp/terraform:light',
    },
    stage: 'plan',
    script: [
      'cd ' + cloud + '/' + env,
      'terraform init',
      'terraform workspace select ' + workspace,
      'terraform plan -out plan.tfplan',
    ],
    allow_failure: false,
    rules: [
      {
        'if': '$COMMIT_REF_NAME == $DEFAULT_BRANCH',
        changes: [cloud + '/' + env + '/**/*'],
      },
      {
        'if': '$PIPELINE_SOURCE == "merge_request_event"',
        changes: [cloud + '/' + env + '/**/*'],
      },
    ],
    artifacts:
      {
        name: env,
        paths: [cloud + '/' + env + '/plan.tfplan'],
      },
  },
  apply(cloud, env, workspace):: {
    image: {
      name: 'hashicorp/terraform:light',
    },
    stage: 'apply',
    script: [
      'cd ' + cloud + '/' + env,
      'terraform init',
      'terraform workspace select ' + workspace,
      'terraform apply plan.tfplan',
    ],
    allow_failure: false,
    rules: [
      {
        'if': '$COMMIT_REF_NAME == $DEFAULT_BRANCH',
        changes: [cloud + '/' + env + '/**/*'],
        when: 'manual',
        allow_failure: true,
      },
    ],
    needs: ['plan:' + workspace],
  },
}
