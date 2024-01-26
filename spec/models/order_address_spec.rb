require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入登録' do
    context '購入者情報に問題がない場合' do
      it "token,post_code,prefecture_id,city,street_address,building,phone_numberが適切に入力されていれば購入ができること" do
        expect(@order_address).to be_valid
      end
      it "buildingの入力がなくても購入ができること" do
        @order_address.building = ""
        expect(@order_address).to be_valid
      end
    end

    context '購入者情報に問題がある場合' do
      it "ユーザー情報がないと購入ができないこと" do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it "tokenが空では購入ができないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it "郵便番号が空では購入ができないこと" do
        @order_address.post_code = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it "郵便番号が「3桁-4桁」でなければ購入ができないこと" do
        @order_address.post_code = "1234567"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code は123-4567の形式で入力してください")
      end
      it "郵便番号が全角数字では購入ができないこと" do
        @order_address.post_code = "１２３-４５６７"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code は123-4567の形式で入力してください")
      end
      it "都道府県は何か選択していないと購入ができないこと" do
        @order_address.prefectures_id = "1"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefectures can't be blank")
      end
      it "市区町村が空では購入ができないこと" do
        @order_address.city = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it "番地が空では購入ができないこと" do
        @order_address.street_address = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street address can't be blank")
      end
      it "電話番号が空では購入ができないこと" do
        @order_address.phone_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it "電話番号が10桁未満の数字では購入ができないこと" do
        @order_address.phone_number = "090123456"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁以上11桁未満の数字で入力してください")
      end
      it "電話番号が11桁以上の数字では購入ができないこと" do
        @order_address.phone_number = "090123456789"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁以上11桁未満の数字で入力してください")
      end
      it "電話番号が090-1234-5678等ハイフンが入っては購入ができないこと" do
        @order_address.phone_number = "090-1234-567"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁以上11桁未満の数字で入力してください")
      end
      it "電話番号が全角数字では購入ができないこと" do
        @order_address.phone_number = "０９０１２３４５６７８"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁以上11桁未満の数字で入力してください")
      end
      it "商品が存在していないと購入ができないこと" do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
