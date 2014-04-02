# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
#
#every 2.minutes do
#  rake "app:populate_weeks"
#  rake "app:populate_years"
#  rake "app:populate_months"
#end
#
every :day, :at => '11:59pm' do
  rake "app:populate_days"
end

every :saturday, :at => '11:59pm' do
  rake "app:populate_weeks"
  rake "app:populate_months"
  rake "app:populate_biannuals"
  rake "app:populate_years"
end

every [ :monday, :tuesday, :wednesday, :thursday, :friday] , :at => '4pm' do 
  rake "app:alert_days"
  rake "app:alert_slack_days"
end

every :thursday, :at => '4pm' do
  rake "app:alert_weeks"
  rake "app:alert_slack_weeks"
end
#every 2.minutes do
  #rake "app:alert_weeks"
#end
