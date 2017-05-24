json.extract! project, :id, :name, :client, :end_date, :status, :created_at, :updated_at
json.url project_url(project, format: :json)
