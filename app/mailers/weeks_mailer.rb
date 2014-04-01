class WeeksMailer < ActionMailer::Base
  default from: "weeklyTasks@thedatacave.com"

  def weekly_email(wuncompleted,muncompleted,buncompleted,yuncompleted)
    @wuncompleted = wuncompleted
    @muncompleted = muncompleted
    @buncompleted = buncompleted
    @yuncompleted = yuncompleted
    @wurl = 'http://checklist.data-cave.com:3000/weeks'
    @murl = 'http://checklist.data-cave.com:3000/months'
    @burl = 'http://checklist.data-cave.com:3000/biannuals'
    @yurl = 'http://checklist.data-cave.com:3000/years'
    mail(to: 'jchamplin@thedatacave.com, pgill@thedatacave.com', subject: 'Weekly Task Report')
  end
end
