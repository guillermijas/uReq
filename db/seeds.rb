# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
Project.create(id: 1, name: 'test project', client: 'John Smith', status: 'open', created_at: '2017-05-21 18:07:46.613458', updated_at: '2017-05-21 18:07:46.613458')
Requirement.create(id: 1, project_id: 1, user_id: 1, description: 'test requirement', status: 'pending', created_at: '2017-05-21 18:07:46.613458', updated_at: '2017-05-21 18:07:46.613458')
Comment.create(id: 1, requirement_id: 1, user_id: 1, body: 'test comment', created_at: '2017-05-21 18:07:46.613458', updated_at: '2017-05-21 18:07:46.613458')

#   Character.create(name: 'Luke', movie: movies.first)
