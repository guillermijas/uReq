class Project < ApplicationRecord
  has_attached_file :picture, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  attr_accessor :delete_picture
  before_validation { picture.clear if delete_picture == '1' }



  validates :name, presence: true, allow_blank: false
  validates :status, inclusion: { in: %w(planning in_proccess on_hold verifying archived),
                                message: "'%{value}' no es un estado válido" }

  has_many :user_projects, dependent: :destroy
  has_many :users, -> { distinct }, through: :user_projects

  has_many :requirements, dependent: :destroy
  has_one :glossary, dependent: :destroy
end
