class Requirement < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :project

  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :id_in_project, presence: true
  validates :level, inclusion: { in: %w[high medium low],
                                 message: "'%<value>s' no es un nivel válido" }
  validates :status, inclusion: { in: %w[pending in_process verifying done rejected],
                                  message: "'%<value>s' no es un estado válido" }

  # ===============
  # = CSV support =
  # ===============
  comma do
    id_string 'ID'
    plain_text_description 'Descripción'
    t_status 'Estado'
    category 'Categoria'
    t_level 'Nivel'
    comments size: 'Comments'
  end
  # ===============
  # =   End CSV   =
  # ===============

  def id_string
    if suffix.blank?
      id_in_project
    else
      "#{suffix}-#{id_in_project}"
    end
  end

  def t_status
    case status
    when 'pending'
      'Pendiente'
    when 'in_process'
      'En proceso'
    when 'verifying'
      'Verificando'
    when 'done'
      'Hecho'
    when 'rejected'
      'Rechazado'
    else
      'Error'
    end
  end

  def t_level
    case level
    when 'high'
      'Alto'
    when 'medium'
      'Medio'
    when 'low'
      'Bajo'
    else
      'Error'
    end
  end

  def plain_text_description
    ActionView::Base.full_sanitizer.sanitize(description)
  end

  def next_id(project_id)
    last_req = Requirement.where(project_id: project_id).last
    last_req.nil? ? 1 : last_req.id_in_project + 1
  end
end
