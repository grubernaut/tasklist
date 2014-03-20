json.array!(@biannuals) do |biannual|
  json.extract! biannual, :id, :title, :completed_by, :completed
  json.url biannual_url(biannual, format: :json)
end
