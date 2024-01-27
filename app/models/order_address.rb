class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefectures_id, :city, :street_address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :city, :street_address, :user_id, :item_id, :token
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "は123-4567の形式で入力してください" }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁以上11桁未満の数字で入力してください"}
  end
  validates :prefectures_id, numericality: { other_than: 1 , message: "can't be blank"}

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefectures_id: prefectures_id, city: city, street_address: street_address, building: building, phone_number: phone_number, order_id: order.id)
  end
end