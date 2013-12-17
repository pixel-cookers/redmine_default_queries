Redmine::Plugin.register :redmine_default_queries do
  name 'Redmine Default Queries plugin'
  author 'Jeremie Augustin'
  description 'Allow to setup default query per project you need to add a query_id custom field'
  version '0.0.1'
  
  requires_redmine :version_or_higher => '2.0.0'
  
end

require 'query_per_project_patch'
