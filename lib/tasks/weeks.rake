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
    require 'net/http'
    require 'uri'
    require 'json'

    @weeks = Week.find(:all, :order => "id desc", :limit => 4).reverse
    @months = Month.find(:all, :order => "id desc", :limit => 6).reverse
    @biannuals = Biannual.find(:all, :order => "id desc", :limit => 8).reverse
    @years = Year.find(:all, :order => "id desc", :limit => 9).reverse

    comWeek = []
    comMonth = []
    comBiannual = []
    comYear = []
    unComWeek = []
    unComMonth = []
    unComBiannual = []
    unComYear = []

    @weeks.each do |week|
      if week.completed
        comWeek << { :title => week.title, :value => "By -> #{week.completed_by}", :short => true}
      else
        unComWeek << { :title => week.title, :value => "Not Completed!", :short => true}
      end
    end

    @months.each do |month|
      if month.completed
        comMonth << { :title => month.title, :value => "By -> #{month.completed_by}", :short => true}
      else
        unComMonth << { :title => month.title, :value => "Not Completed!", :short => true}
      end
    end

    @biannuals.each do |biannual|
      if biannual.completed
        comBiannual << { :title => biannual.title, :value => "By -> #{biannual.completed_by}", :short => true}
      else
        unComBiannual << { :title => biannual.title, :value => "Not Completed!", :short => true}
      end
    end

    @years.each do |year|
      if year.completed
        comYear << { :title => year.title, :value => "By -> #{year.completed_by}", :short => true}
      else
        unComYear << { :title => year.title, :value => "Not Completed!", :short => true}
      end
    end

    # Week 
    if comWeek.length < 1
      comWeek << { :title => "No Weekly Items Completed" }
    end

    if unComWeek.length < 1
      unComWeek << { :title => "No Weekly Items Left!" }
    end

    # Month
    if comMonth.length < 1
      comMonth << { :title => "No Monthly Items Completed" }
    end

    if unComMonth.length < 1
      unComMonth << { :title => "No Monthly Items Left!" }
    end

    # Bi-Annual
    if comBiannual.length < 1
      comBiannual << { :title => "No Biannual Items Completed" }
    end

    if unComBiannual.length < 1
      unComBiannual << { :title => "No Biannual Items Left!" }
    end

    # Year
    if comYear.length < 1
      comYear << { :title => "No Yearly Items Completed" }
    end

    if unComYear.length < 1
      unComYear << { :title => "No Yearly Items Left!" }
    end

    uri = URI.parse("https://datacave.slack.com/services/hooks/incoming-webhook?token=#{ENV["SLACK_BOT_TOKEN"]}")
    header = {'Content-Type' => 'text/json'}

    payload = {
      channel: "#devtest",
      username: "Facilities-Checklist-Bot",
      attachments: [
        {
          fallback: "Text Summary",
          pretext: "#{Date.today.to_s} Weekly Snapshot of Completed Weekly Items:",
          color: 'good',
          fields: comWeek
        },
        {
          fallback: "Text Summary",
          pretext: "#{Date.today.to_s} Weekly Snapshot of UnCompleted Weekly Items:",
          color: 'danger',
          fields: unComWeek
        },
        {
          fallback: "Text Summary",
          pretext: "#{Date.today.to_s} Weekly Snapshot of Completed Monthly Items:",
          color: 'good',
          fields: comMonth
        },
        {
          fallback: "Text Summary",
          pretext: "#{Date.today.to_s} Weekly Snapshot of UnCompleted Monthly Items:",
          color: 'danger',
          fields: unComMonth
        },
        {
          fallback: "Text Summary",
          pretext: "#{Date.today.to_s} Weekly Snapshot of Completed Biannual Items:",
          color: 'good',
          fields: comBiannual
        },
        {
          fallback: "Text Summary",
          pretext: "#{Date.today.to_s} Weekly Snapshot of UnCompleted Biannual Items:",
          color: 'danger',
          fields: unComBiannual
        },
        {
          fallback: "Text Summary",
          pretext: "#{Date.today.to_s} Weekly Snapshot of Completed Yearly Items:",
          color: 'good',
          fields: comYear
        },
        {
          fallback: "Text Summary",
          pretext: "#{Date.today.to_s} Weekly Snapshot of UnCompleted Yearly Items:",
          color: 'danger',
          fields: unComYear
        }
      ]
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, header)
    req.body = payload.to_json

    resp = http.request(req)
    puts resp
  end

end
