require 'flog_reporter'
require 'rails'

module FlogReporter
  class Railtie < Rails::Railtie
    railtie_name :flog_reporter

    rake_tasks do
      load 'chatgpt_code_review/tasks/flog_reporter.rake'
    end
  end
end
