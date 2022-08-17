class Genre < ApplicationRecord

  has_many:items, dependent: :destroy

  validates :name, presence: true

  def self.create_order(create_time)
    page(create_time).order(created_at: :DESC)
  end

  def self.update_order(update_time)
    page(update_time).order(updated_at: :DESC)
  end

end
