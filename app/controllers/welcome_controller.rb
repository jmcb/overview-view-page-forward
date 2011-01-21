class WelcomeController < ApplicationController
  unloadable

  before_filter :forward_projects, :only => :index

  def forward_projects
    @projects = Project.latest User.current

    redirect_to :controller => "projects"
  end
end
