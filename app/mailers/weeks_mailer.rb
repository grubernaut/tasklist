class WeeksMailer < ActionMailer::Base
  default from: "weeklyTasks@thedatacave.com"

  def weekly_email(wuncompleted,muncompleted,buncompleted,yuncompleted)
    @wuncompleted = wuncompleted
    @muncompleted = muncompleted
    @buncompleted = buncompleted
    @yuncompleted = yuncompleted
    mail(to: 'jchamplin@thedatacave.com', subject: 'Weekly Task Report')
  end
end
