class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :projects
  has_many :requirements
  has_many :comments

  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def project_manager?
    role == 'project_manager'
  end

  def admin?
    role == 'admin'
  end

  def collaborator?
    role == 'collaborator'
  end

end
