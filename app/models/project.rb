class Project < ApplicationRecord
  has_many :users, through: :user_projects
  has_many :requirements
  has_one :glossary
end
