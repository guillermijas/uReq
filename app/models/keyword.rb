class Keyword < ApplicationRecord
  belongs_to :project

  validates :key, presence: true, allow_blank: false
  validates :definition, presence: true, allow_blank: false

  after_create :replace_keyword_in_requirement
  before_destroy :remove_keyword_in_requirements

  # Crea o actualiza las etiquetas <abbr title="description"></abbr>
  def replace_keyword_in_requirement
    reqs = Requirement.where(project: project)
    reqs.each do |req|
      next unless req.description.include?(key)
      abbr = "<abbr title='#{definition}'>#{key}</abbr>"
      newdesc = if req.description.grep(%r{<abbr title='[A-Za-z0-9 ,.\-]*'>#{key}</abbr>})
                  req.description.gsub(%r{<abbr title='[A-Za-z0-9 ,.\-]*'>#{key}</abbr>}, abbr)
                else
                  req.description.gsub(key, abbr)
                end
      req.update(description: newdesc)
      req.save
    end
  end

  # Solo elimina las etiquetas <abbr title="description"></abbr>
  def remove_keyword_in_requirements
    reqs = Requirement.where(project: project)
    reqs.each do |req|
      next unless req.description.grep(%r{<abbr title='[A-Za-z0-9 ,.\-]*'>#{key}</abbr>})
      newdesc = req.description.gsub(%r{<abbr title='[A-Za-z0-9 ,.\-]*'>#{key}</abbr>}, key)
      req.update(description: newdesc)
      req.save
    end
  end
end
