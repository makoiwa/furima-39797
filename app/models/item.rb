class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_cost
  belongs_to :prefectures
  belongs_to :shipment_day

  validates :image, :item, :explanation, presence: true

  validates :category_id, :condition_id, :delivery_cost_id, :prefectures_id, :shipment_day_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to:9999999, message:"は範囲外です" }

end