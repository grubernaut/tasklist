json.array!(@weeks) do |week|
  json.extract! week, :id, :title, :completed_by, :completed
  json.url week_url(week, format: :json)
end
