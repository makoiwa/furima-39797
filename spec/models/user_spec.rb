require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = 'a0000'
      @user.password = 'a0000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'パスワードは、数字のみのパスワードでは登録できない' do
      @user.password = '000000'
      @user.password_confirmation = '000000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は半角英数字の組み合わせで入力してください")
    end
    it 'パスワードは、英字のみのパスワードは登録できない' do
      @user.password = 'aaabbb'
      @user.password_confirmation = 'aaabbb'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は半角英数字の組み合わせで入力してください")
    end
    it 'パスワードは、全角文字を含むパスワードでは登録できない' do
      @user.password = 'ｂ０００００'
      @user.password_confirmation = 'ｂ０００００'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は半角英数字の組み合わせで入力してください")
    end
    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      @user.password_confirmation = 'b00000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '新規登録/本人情報確認' do
    it 'お名前(全角)は、名字が必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'お名前(全角)は、名前が必須であること' do
      @user.second_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Second name can't be blank")
    end
    it '名字(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'test'
      @user.valid?

      expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
    end
    it '名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.second_name = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("Second name is invalid. Input full-width characters.")
    end
    it 'お名前カナ(全角)は、名字が必須であること' do
      @user.f_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("F name kana can't be blank")
    end
    it 'お名前カナ(全角)は、名前が必須であること' do
      @user.s_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("S name kana can't be blank")
    end
    it '名字カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.f_name_kana = 'てすと'
      @user.valid?
      expect(@user.errors.full_messages).to include("F name kana is invalid. Input full-width katakana characters.")
    end
    it '名字カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.f_name_kana = '山田'
      @user.valid?
      expect(@user.errors.full_messages).to include("F name kana is invalid. Input full-width katakana characters.")
    end
    it '名字カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.f_name_kana = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("F name kana is invalid. Input full-width katakana characters.")
    end
    it '名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.s_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include("S name kana is invalid. Input full-width katakana characters.")
    end
    it '名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.s_name_kana = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include("S name kana is invalid. Input full-width katakana characters.")
    end
    it '名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.s_name_kana = 'tester'
      @user.valid?
      expect(@user.errors.full_messages).to include("S name kana is invalid. Input full-width katakana characters.")
    end
    it '生年月日が必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

  end
end
