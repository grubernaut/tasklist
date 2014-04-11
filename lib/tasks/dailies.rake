namespace :app do

  desc "Populate Days with data"
  task :populate_days => :environment do
    @days = Daily.all
    @days.each do |active|
      if active.completed == false
        active.update_attribute :completed, true
        active.update_attribute :completed_by, "NotClaimed"
      end
    end

    #INSERT THESE
    [
      {:title => "Inspect Generators", :completed => false},
      {:title => "Inspect Cooling Towers", :completed => false},
      {:title => "Inspect West Fence and West Gates", :completed => false},
      {:title => "Inspect West Side Drainage", :completed => false},
      {:title => "Inspect East and West Building AC Units for Office Area", :completed => false},
      {:title => "Check for Overall Leaks in Maintenance Areas", :completed => false},
      {:title => "Inspect Switchgear", :completed => false},
      {:title => "Verify no Faults or Warnings on UPS Flywheels", :completed => false},
      {:title => "Verify no Faults or Warnings on Chillers", :completed => false},
      {:title => "Verify no Faults or Warnings on PDUs", :completed => false},
      {:title => "Change Water Filter in Cooling Towers", :completed => false},
    ].each do |attributes|
      Daily.create(attributes)
    end
  end

  desc "Alert Day"
  task :alert_days => :environment do
    #Week.alert
    @active = Daily.active
    if @active.count > 0
      DailyMailer.daily_email(@active).deliver
    end
  end

  desc "Alert Day Slack"
  task :alert_slack_days => :environment do
    require 'json'
    require 'uri'
    require 'json'

    uri = URI.parse("https://datacave.slack.com/services/hooks/incoming-webhook?token=#{ENV["SLACK_BOT_TOKEN"]}")
    header = {'Content-Type' => 'text/json'}

    comToday = []
    unComToday = []
    @days = Daily.find(:all, :order => "id desc", :limit => ENV["DAILY_ITEMS"]).reverse
    @days.each do |daily|
      if daily.completed
        comToday << { :title => daily.title, :value => "By -> #{daily.completed_by}", :short => true}
      else
        unComToday << { :title => daily.title, :value => "Not Completed!", :short => true}
      end
    end
    
    if unComToday.length > 0
     payload = {
       channel: "#devtest",
       username: "Facilities-Checklist-Bot",
       attachments: [
         {
           fallback: "Text Summary",
           pretext: "Daily Snapshot for #{Date.today.to_s} of Completed Items:",
           color: 'good',
           fields: comToday
         },
         {
           fallback: "Text Summary",
           pretext: "Daily Snapshot for #{Date.today.to_s} of Uncompleted Items:",
           color: 'danger',
           fields: unComToday
         }
       ]
     }
    else
     payload = {
       channel: "#devtest",
       username: "Facilities-Checklist-Bot",
       attachments: [
          {
           fallback: "Text Summary",
           pretext: "Daily Snapshot for #{Date.today.to_s} of Completed Items:",
           color: 'good',
           fields: comToday
          }
        ]
     }
    end

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, header)
    req.body = payload.to_json
    resp = http.request(req)
    puts resp
  end

end
