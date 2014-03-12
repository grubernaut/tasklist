json.array!(@years) do |year|
  json.extract! year, :id, :title, :completed_by, :completed
  json.url year_url(year, format: :json)
end
