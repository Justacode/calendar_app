json.extract! event, :id, :name, :description, :frequency, :user_id, :start_date, :finish_date, :created_at, :updated_at
json.url event_url(event, format: :json)
