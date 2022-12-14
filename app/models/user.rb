class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, length: { maximum: 40 }

  with_options presence: true do
    validates :nickname, :user_birth_date
    validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]/, message: 'は全角ひらがな、全角カタカナ、漢字で入力して下さい' }
    validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力して下さい' }
  end
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数で入力して下さい' }
end
