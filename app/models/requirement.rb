class Requirement < ApplicationRecord
  belongs_to :project, required: true
  belongs_to :user, required: true
  has_many :comments, dependent: :destroy
end
