class CartItem < ApplicationRecord

  belongs_to :item
  belongs_to :customer

  # 税込価格
  def tax_include_price
    (item.price * 1.10).round(0)
  end

  # +=、合計の表示方法
  def subtotal
    tax_include_price * amount
  end

end
