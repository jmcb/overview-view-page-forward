require 'redmine'

require 'dispatcher'

Dispatcher.to_prepare :overview_view_page_forward do
    require_dependency 'projects_helper'
    ProjectsHelper.send(:include, OverviewForwardPluginPatch) unless ProjectsHelper.included_modules.include?(OverviewForwardPluginPatch)
end

Redmine::Plugin.register :overview_view_page_forward do
  name 'Overview->View page forward'
  author 'Jon McManus'
  url 'http://github.com/jmcb/overview-view-page-forward'
  author_url 'http://githu.com/jmcb'
  description 'Take a Redmine user directly to the Issues page when entering a project from the Projects page.'
  version '0.1'

  requires_redmine :version_or_higher => '0.8.0'
end
