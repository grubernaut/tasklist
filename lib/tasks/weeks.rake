namespace :app do

  desc "Populate Weeks with data"
  task :populate_weeks => :environment do
    @weeks = Week.all
    @weeks.each do |active|
      active.update_attribute :completed, true
      active.update_attribute :completed_by, "NotClaimed"
    end

    #INSERT THESE
    [
      {:title => "Start Test Cummins Generators", :completed => false},
      {:title => "Inspect interior of Cummins Generators", :completed => false},
      {:title => "Check Water Quality in the Wells", :completed => false},
      {:title => "Check Salt in Brine Tanks", :completed => false},
    ].each do |attributes|
      Week.create(attributes)
    end
  end

  desc "Alert Week"
  task :alert_weeks => :environment do
    #Week.alert
    @wactive = Week.active
    @mactive = Month.active
    @bactive = Biannual.active
    @yactive = Year.active
    if @yactive.count > 0
      WeeksMailer.weekly_email(@wactive,@mactive,@bactive,@yactive).deliver
    end
  end

  desc "Alert Week Slack"
  task :alert_slack_weeks => :environment do 
    @wactive = Week.active
    @mactive = Month.active
    @bactive = Biannual.active
    @yactive = Year.active

    payload_week = ""
    payload_month = ""
    payload_biannual = ""
    payload_year = ""

    @wactive.each do |active|
      payload_week << "\t-#{active.title}\n"
    end

    @mactive.each do |active|
      payload_month << "\t-#{active.title}\n"
    end

    @bactive.each do |active|
      payload_biannual << "\t-#{active.title}\n"
    end

    @yactive.each do |active|
      payload_year << "\t-#{active.title}\n"
    end

    require 'net/http'
    require 'uri'
    require 'json'

    uri = URI.parse("https://datacave.slack.com/services/hooks/incoming-webhook?token=#{ENV["SLACK_BOT_TOKEN"]}")
    header = {'Content-Type' => 'text/json'}

    payload = {
      channel: "#devtest",
      username: "Facilities-Checklist-Bot",
      text: "<http://checklist.data-cave.com/weeks|Weekly Tasks> that Still Need Completed:\n#{payload_week}\n\n<http://checklist.data-cave.com/months|Monthly Tasks> that Still Need Completed:\n#{payload_month}\n\n<http://checklist.data-cave.com/biannuals|Bi-Annual Tasks> that Still Need Completed:\n#{payload_biannual}\n\n<http://checklist.data-cave.com/years|Yearly Tasks> that Still Need Completed:\n#{payload_year}"
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, header)
    req.body = payload.to_json

    resp = http.request(req)
  end
end
