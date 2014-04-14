class ReportController < ApplicationController
  def index
    @days = Daily.all
    @weeks = Week.all
    @months = Month.all
    @biannuals = Biannual.all
    @years = Year.all
    #Post.where("published_at >= ? and published_at < ?", range_start, range_end)

  end
end
