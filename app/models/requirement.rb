class Requirement < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :project

  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :id_in_project, presence: true
  validates :level, inclusion: { in: %w[high medium low],
                                 message: "'%{value}' no es un nivel válido" }
  validates :status, inclusion: { in: %w[pending in_process verifying done rejected],
                                  message: "'%{value}' no es un estado válido" }

  def id_string
    if suffix.blank?
      id_in_project
    else
      "#{suffix}-#{id_in_project}"
    end
  end

  def next_id(project_id)
    last_req = Requirement.where(project_id: project_id).last
    last_req.nil? ? 1 : last_req.id_in_project + 1
  end

end
