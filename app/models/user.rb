class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false

  has_many :user_projects, dependent: :destroy
  has_many :projects, -> { distinct }, through: :user_projects

  has_many :requirements
  has_many :comments

  def full_name
    first_name + ' ' + last_name
  end

  def user_role
    case role
      when 'collaborator'
        'Colaborador'
      when 'admin'
        'Administrador'
      when 'project_manager'
        'Jefe de proyecto'
      else
        'Sin definir'
    end
  end
end
