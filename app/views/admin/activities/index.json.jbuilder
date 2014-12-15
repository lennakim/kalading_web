json.array!(@admin_activities) do |admin_activity|
  json.extract! admin_activity, :id
  json.url admin_activity_url(admin_activity, format: :json)
end
