class ReportController < ApplicationController
	# GET /reports
	# GET /reports.json

  def index
    @days = Daily.all.order('created_at ASC')
    @weeks = Week.all.order('created_at ASC')
    @months = Month.all.order('created_at ASC')
    @biannuals = Biannual.all.order('created_at ASC')
    @years = Year.all.order('created_at ASC')
    #Post.where("published_at >= ? and published_at < ?", range_start, range_end)

    @reports = Report.all.order('created_at DESC')
  end
end
