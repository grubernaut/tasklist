class DailyMailer < ActionMailer::Base
  default from: "dailyTasks@thedatacave.com"

  def daily_email(uncompleted)
    @uncompleted = uncompleted
    mail(to: 'jchamplin@thedatacave.com', subject: "Daily Task Report")
  end
end
