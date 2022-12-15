class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :city, :prefecture_id, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :user_id, :item_id
    validates :prefecture_id, :city, :address, :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid.' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    # 購入情報を保存し、変数orderに代入する
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    Address.create(postal_code: postal_code, city: city, prefecture_id: prefecture_id, address: address, building: building,
                   phone_number: phone_number, order_id: order.id)
  end
end
