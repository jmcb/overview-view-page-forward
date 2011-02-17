module OverviewForwardPluginPatch
    def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
            alias_method_chain :render_project_hierarchy, :issue_link
        end
    end

    module InstanceMethods

        def render_project_hierarchy_with_issue_link (projects)
            s = ''
            if projects.any?
                ancestors = []
                original_project = @project
                projects.each do |project|
                # set the project environment to please macros.
                    @project = project
                    if (ancestors.empty? || project.is_descendant_of?(ancestors.last))
                        s << "<ul class='projects #{ ancestors.empty? ? 'root' : nil}'>\n"
                    else
                        ancestors.pop
                        s << "</li>"
                        while (ancestors.any? && !project.is_descendant_of?(ancestors.last)) 
                            ancestors.pop
                            s << "</ul></li>\n"
                          end
                    end
                    classes = (ancestors.empty? ? 'root' : 'child')
                    s << "<li class='#{classes}'><div class='#{classes}'>" +
                         link_to_project(project, {:action => 'issues'}, :class => "project #{User.current.member_of?(project) ? 'my-project' : nil}")
                    s << "<div class='wiki description'>#{textilizable(project.short_description, :project => project)}</div>" unless project.description.blank?
                    s << "</div>\n"
                    ancestors << project
                end
                s << ("</li></ul>\n" * ancestors.size)
                @project = original_project
            end
            s
        end
    
    end
end 
