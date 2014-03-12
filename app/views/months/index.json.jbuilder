json.array!(@months) do |month|
  json.extract! month, :id, :title, :completed_by, :completed
  json.url month_url(month, format: :json)
end
