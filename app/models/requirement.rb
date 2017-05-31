class Requirement < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :project

  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :level, inclusion: { in: %w[high medium low],
                                 message: "'%{value}' no es un nivel válido" }
  validates :status, inclusion: { in: %w[pending in_progress verifying rejected],
                                  message: "'%{value}' no es un nivel válido" }

end
