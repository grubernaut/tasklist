class WeeksMailer < ActionMailer::Base
  default from: "weeklyTasks@thedatacave.com"

  def weekly_email(wuncompleted,muncompleted,buncompleted,yuncompleted)
    @wuncompleted = wuncompleted
    @muncompleted = muncompleted
    @buncompleted = buncompleted
    @yuncompleted = yuncompleted
    @wurl = 'http://checklist.data-cave.com/weeks'
    @murl = 'http://checklist.data-cave.com/months'
    @burl = 'http://checklist.data-cave.com/biannuals'
    @yurl = 'http://checklist.data-cave.com/years'
    mail(to: 'network.operations@thedatacave.com, facilities@thedatacave.com, jchamplin@thedatacave.com', subject: 'Weekly Task Report')
  end
end
