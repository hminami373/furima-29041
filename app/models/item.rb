class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :item_category
  belongs_to :item_sales_status
  belongs_to :item_shipping_fee_status
  belongs_to :prefecture
  belongs_to :item_scheduled_delivery
  has_one_attached :image

    #空の投稿を保存できないようにする
    validates :user_id, :item_name, :item_info, :item_category_id, :item_sales_status_id, :item_shipping_fee_status_id, :prefecture_id, :item_scheduled_delivery_id, :item_price,  presence: true

    #ジャンルの選択が「---」の時は保存できないようにする
    validates :item_category_id, numericality: { other_than: 1 } 
    validates :item_sales_status_id, numericality: { other_than: 1 } 
    validates :item_shipping_fee_status_id, numericality: { other_than: 1 } 
    validates :prefecture_id, numericality: { other_than: 1 } 
    validates :item_scheduled_delivery_id, numericality: { other_than: 1 } 
  
end
