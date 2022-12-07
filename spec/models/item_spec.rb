require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の保存' do
    context '商品が出品できる場合' do
      it '画像と商品名と商品説明とカテゴリーと状態と配送料の負担と発送元の地域と発送までの日数と販売価格があれば投稿できる' do
        expect(@item).to be_valid
      end
    end
    context '商品が出品できない場合' do
      it '画像が空では投稿できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank") 
      end     
      it '商品名が空では投稿できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank") 
      end       
      it '商品説明が空では投稿できない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item info can't be blank") 
      end       
      it 'カテゴリーが空では投稿できない' do
        @item.item_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank") 
      end       
      it '状態が空では投稿できない' do
        @item.item_sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item sales status can't be blank") 
      end       
      it '配送料の負担が空では投稿できない' do
        @item.item_shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item shipping fee status can't be blank") 
      end       
      it '発送元の地域が空では投稿できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank") 
      end 
      it '発送までの日数が空では投稿できない' do
        @item.item_scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item scheduled delivery can't be blank") 
      end 
      it '販売価格が空では投稿できない' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price can't be blank") 
      end 
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')      
      end
      it '価格は、¥300以上でなければ保存できない' do
        @item.item_price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price must be greater than or equal to 300')      
      end      
      it '価格は、¥9,999,999以下でなければ保存できない' do
        @item.item_price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price must be less than or equal to 9999999')      
      end      
      it '価格は半角数値でなければ保存できない' do
        @item.item_price = 'about300'
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is not a number')      
      end
    end
  end
end
