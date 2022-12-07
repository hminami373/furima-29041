FactoryBot.define do
  factory :item do
    item_name                  { 'オムライス' }
    item_info                  { '山田着用品' }
    item_category_id              { 2 }
    item_sales_status_id          { 2 }
    item_scheduled_delivery_id    { 2 }
    prefecture_id                 { 2 }
    item_shipping_fee_status_id   { 2 }
    item_price                    {1000}
    association :user 
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/food_omurice.png'), filename: 'food_omurice.png')
    end

  end
end
