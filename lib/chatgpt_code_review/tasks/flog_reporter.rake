namespace :flog_reporter do
  desc 'List methods with a complexity score over 30'
  task :high_complexity => :environment do
    FlogReporter.generate_report
  end
end
