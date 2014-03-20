json.array!(@dailies) do |daily|
  json.extract! daily, :id, :title, :completed_by, :completed
  json.url daily_url(daily, format: :json)
end
