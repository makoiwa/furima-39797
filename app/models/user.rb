class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :first_name, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, allow_blank: true }
    validates :second_name, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, allow_blank: true }
    validates :f_name_kana, presence: true, format: {with: /\A[ァ-ヶー]+\z/, allow_blank: true }
    validates :s_name_kana, presence: true, format: {with: /\A[ァ-ヶー]+\z/, allow_blank: true }
    validates :birthday
  end
  validates :password, format: {with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "は半角英数字の組み合わせで入力してください"}
end
