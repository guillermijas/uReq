json.extract! project, :id, :name, :client, :start_date, :finish_date, :status, :created_at, :updated_at
json.url project_url(project, format: :json)
