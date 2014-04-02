class DailyMailer < ActionMailer::Base
  default from: "dailyTasks@thedatacave.com"

  def daily_email(uncompleted)
    @uncompleted = uncompleted
    @url = 'http://checklist.data-cave.com/dailies'
    mail(to: 'network.operations@thedatacave.com, facilities@thedatacave.com, jchamplin@thedatacave.com', subject: "Daily Task Report")
  end
end
