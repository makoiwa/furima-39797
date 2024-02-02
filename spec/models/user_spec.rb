require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '新規登録できるとき' do
      it 'nickname,email,password,password_confirmation,first_name,second_name,f_name_kana,s_name_kana,birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録/ユーザー情報ができない時' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'a0000'
        @user.password = 'a0000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'パスワードは、数字のみのパスワードでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の組み合わせで入力してください")
      end
      it 'パスワードは、英字のみのパスワードは登録できない' do
        @user.password = 'aaabbb'
        @user.password_confirmation = 'aaabbb'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の組み合わせで入力してください")
      end
      it 'パスワードは、全角文字を含むパスワードでは登録できない' do
        @user.password = 'ｂ０００００'
        @user.password_confirmation = 'ｂ０００００'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の組み合わせで入力してください")
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password_confirmation = 'b00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end

    context '新規登録/本人情報確認ができない時' do
      it 'お名前(全角)は、名字が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end
      it 'お名前(全角)は、名前が必須であること' do
        @user.second_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を入力してください")
      end
      it '名字(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'test'
        @user.valid?

        expect(@user.errors.full_messages).to include("名字は不正な値です")
      end
      it '名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.second_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓は不正な値です")
      end
      it 'お名前カナ(全角)は、名字が必須であること' do
        @user.f_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（カナ）を入力してください")
      end
      it 'お名前カナ(全角)は、名前が必須であること' do
        @user.s_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カナ）を入力してください")
      end
      it '名字カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.f_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（カナ）は不正な値です")
      end
      it '名字カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.f_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（カナ）は不正な値です")
      end
      it '名字カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.f_name_kana = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（カナ）は不正な値です")
      end
      it '姓カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.s_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カナ）は不正な値です")
      end
      it '姓カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.s_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カナ）は不正な値です")
      end
      it '姓カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.s_name_kana = 'tester'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カナ）は不正な値です")
      end
      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
    end
  end
end
