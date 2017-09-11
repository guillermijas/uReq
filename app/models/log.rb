class Log < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :requirement, optional: true
end
