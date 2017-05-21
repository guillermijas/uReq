class Comment < ApplicationRecord
  belongs_to :requirement, required: true
  belongs_to :user, required: true
  validates_presence_of :requirement_id
  validates_presence_of :user_id
end
