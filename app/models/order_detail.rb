class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: { not_startable: 0, wait_product: 1, in_product: 2, finish_product: 3}

  def subtotal
    price*amount
  end

end
