User.create!([
                 {email: "guillermijas@gmail.com", password: 'qwerty123', role: 'project_manager', first_name: 'Guillermo', last_name: 'Mora Cordero'},
                 {email: "rossi@gmail.com", password: 'qwerty123', role: 'project_manager', first_name: 'Carlos', last_name: 'Rossi'},
                 {email: "admin@admin.com", password: 'asdf1234', role: 'admin', first_name: 'Admin', last_name: 'Admin'}
             ])
Project.create!([
                    {name: "AGNT Telegrama", client: "Idea Technologies", end_date: "2017-05-25", status: "in_process", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil}
                ])
UserProject.create!([
                        {project_id: 1, user_id: 1, owner: true},
                        {project_id: 1, user_id: 3, owner: true}
                    ])
Log.create!([
                {project_id: 1, user_id: 1, operation: "Guillermo Mora Cordero ha creado el proyecto 'AGNT Telegrama'"},
            ])
