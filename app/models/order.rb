class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  # 支払方法｛クレジットカード、銀行振込｝
  enum payment_method: { credit_card: 0, transfer: 1 }

  # 注文ステータス｛入金待ち、入金確認、準備中、発送準備中｝
  enum status: {waiting_for_deposit: 0, payment_confirmation: 1, in_production: 2, preparing_to_ship: 3, sent: 4}

end
