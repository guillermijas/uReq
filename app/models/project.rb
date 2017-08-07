class Project < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :users, -> { distinct }, through: :user_projects

  has_many :requirements, dependent: :destroy
  has_one :glossary, dependent: :destroy

  has_attached_file :picture, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment_content_type :picture, content_type: ["image/jpeg", "image/gif", "image/png"]

  attr_accessor :delete_picture
  before_validation { picture.clear if delete_picture == '1' }

  validates :name, presence: true, allow_blank: false
  validates :status, inclusion: { in: %w[planning in_process on_hold verifying archived],
                                  message: "'%{value}' no es un estado válido" }

  def status_string
    case status
    when 'planning'
      'Planificando'
    when 'in_process'
      'En proceso'
    when 'on_hold'
      'En espera'
    when 'verifying'
      'Verificando'
    when 'archived'
      'Archivado'
    else
      'Error en el estado'
    end
  end
end
