require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品登録' do
    context '出品ができる時' do
      it 'image,item,explanation,category_id,condition_id,delivery_cost_id,prefectures_id,shipment_day_id,price,userが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '出品ができない時' do
      it 'ユーザー情報がない場合は登録ができない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を入力してください")
      end
      it '商品名が必須であること' do
        @item.item = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品の説明が必須であること' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリーの情報が必須であること' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it '商品の状態の情報が必須であること' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it '配送料の負担の情報が必須であること' do
        @item.delivery_cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it '発送元の地域の情報が必須であること' do
        @item.prefectures_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it '発送までの日数の情報が必須であること' do
        @item.shipment_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end
      it '価格の情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は範囲外です")
      end
      it '価格は、¥299以下では出品できないこと' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は範囲外です")
      end
      it '価格は、¥10,000,000以上では出品できないこと' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は範囲外です")
      end
      it '価格は半角数値のみ保存可能であること' do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は範囲外です")
      end
      it '価格は整数のみ保存可能であること' do
        @item.price = '1000.1'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は範囲外です")
      end
    end
  end
end
