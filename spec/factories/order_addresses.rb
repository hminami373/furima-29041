FactoryBot.define do
  factory :order_address do
    postal_code   { '123-4567' }
    city          { '山形市' }
    prefecture_id { 4 }
    address { '１−１' }
    building      { '第一ビル' }
    phone_number  { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
