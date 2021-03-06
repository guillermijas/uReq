class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: '300x300', thumb: '100x100' }
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false

  has_many :user_projects, dependent: :destroy
  has_many :projects, -> { distinct }, through: :user_projects

  has_many :requirements, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :logs, dependent: :destroy

  def full_name
    first_name + ' ' + last_name
  end

  def short_name
    first_name.first + '. ' + last_name.partition(' ').first
  end

  def self.admins
    User.where(role: 'admin')
  end

  def self.registered_users
    User.where(role: %w[project_manager collaborator])
  end

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'project_manager'
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
