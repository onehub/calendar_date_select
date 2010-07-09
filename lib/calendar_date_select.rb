require "calendar_date_select/calendar_date_select.rb"
require "calendar_date_select/form_helpers.rb"
require "calendar_date_select/includes_helper.rb"

require 'rails'
require 'active_support'

ActiveSupport.on_load(:action_view) do
  ActionView::Helpers::FormHelper.send(:include, CalendarDateSelect::FormHelpers)
  ActionView::Base.send(:include, CalendarDateSelect::FormHelpers)
  ActionView::Base.send(:include, CalendarDateSelect::IncludesHelper)
  
  ActionView::Helpers::InstanceTag.class_eval do
    class << self; alias new_with_backwards_compatibility new; end #TODO: singleton_class.class_eval
  end

end

module CalendarDateSelect

  Files = [
    '/public',
    '/public/javascripts/calendar_date_select',
    '/public/stylesheets/calendar_date_select', 
    '/public/images/calendar_date_select',
    '/public/javascripts/calendar_date_select/locale'
  ]

  class Railtie < ::Rails::Railtie
    rake_tasks do
      desc "Install assets required by calendar_date_select gem"
      task :calendardateselect do
        puts "You're in my_gem"

        Files.each do |dir|
          source = File.dirname(__FILE__) + "/../#{dir}"
          dest = Rails.root + dir
          FileUtils.mkdir_p(dest)
          FileUtils.cp(Dir.glob(source+'/*.*'), dest)
        end if false

      end # task
    end # rake_tasks
  end # Railtie
end # module

