local jobs = import 'jobs.jsonnet';

local conf = {
  envs: [
    { cloud: 'aws', name: 'organization', workspaces: [self.name] },
    { cloud: 'aws', name: 'staging', workspaces: [self.name + '-euwest1', self.name + '-eucentral1'] },
    { cloud: 'aws', name: 'production', workspaces: [self.name + '-euwest1', self.name + '-eucentral1'] },
  ],
};

{
  // Building plan jobs
  ['plan:' + workspace]: jobs.plan(env.cloud, env.name, workspace)
  for env in conf.envs
  for workspace in env.workspaces
}
+
{
  // Building apply jobs
  ['apply:' + workspace]: jobs.apply(env.cloud, env.name, workspace)
  for env in conf.envs
  for workspace in env.workspaces
}
