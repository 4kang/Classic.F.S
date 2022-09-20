class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  # 製作ステータス｛着手不可、準備待ち、準備中、完了｝
  enum making_status: { not_startable: 0, wait_product: 1, in_product: 2, finish_product: 3}

  def subtotal
    price*amount
  end

end
