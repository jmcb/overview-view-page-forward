require 'redmine'

Redmine::Plugin.register :projects_page_forward do
  name 'Projects Page Forward'
  author 'Jon McManus'
  url 'http://github.com/jmcb/projects-page-forward'
  author_url 'http://githu.com/jmcb'
  description 'Forward a Redmine user to the projects page, bypassing the home page.'
  version '0.1'

  requires_redmine :version_or_higher => '0.8.0'
end
