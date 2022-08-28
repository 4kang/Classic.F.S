class Item < ApplicationRecord

  has_many :favorites,     dependent: :destroy
  has_many :cart_items,    dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :item_comments, dependent: :destroy
  belongs_to :genre

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?

      if Rails.env.productiont?
        file_path = Rails.root.join(asset_path("images/no_image.jpg")).to_s
      else
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
      end

      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

# 税込価格
  def tax_include_price
    (price * 1.10).round(0)
  end

# ジャンル検索
  def self.search_for(model, search_value)
    if model == "item"
      Item.where("name LIKE ?", "%#{search_value}%")
    else
      Item.where(genre_id: search_value)
    end
  end

  # いいね機能
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

end
