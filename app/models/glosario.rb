class Glosario < ApplicationRecord
  validates_presence_of :key
  validates_uniqueness_of :key
end
