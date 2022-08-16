class Genre < ApplicationRecord


  has_many:items
  has_ancestry

  validates :name, presence: true

end
