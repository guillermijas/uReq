class Requirement < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :project
end
