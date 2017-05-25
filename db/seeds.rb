User.create!([
                 {email: "guillermijas@gmail.com", password: 'qwerty123', role: 'project_manager'},
                 {email: "rossi@gmail.com", password: 'qwerty123', role: 'project_manager'},
                 {email: "admin@admin.com", password: 'asdf1234', role: 'admin'}
             ])
Project.create!([
                    {name: "AGNT Telegrama", client: "Idea Technologies", end_date: "2017-05-25", status: "En proceso", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil}
                ])
UserProject.create!([
                        {project_id: 1, user_id: 1, owner: true},
                        {project_id: 1, user_id: 3, owner: true}
                    ])
