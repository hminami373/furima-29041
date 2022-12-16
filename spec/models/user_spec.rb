require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation, last_name, first_name, last_name_kana, first_name_kana, user_birth_date が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前を入力してください')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前を入力してください')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナを入力してください')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナを入力してください')
      end
      it 'user_birth_dateが空では登録できない' do
        @user.user_birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'testtest'
        @user.password_confirmation = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数で入力して下さい')
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数で入力して下さい')
      end
      it 'passwordが全角数値混合では登録できない' do
        @user.password = '1２3456'
        @user.password_confirmation = '1２3456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数で入力して下さい')
      end
      it 'last_nameはスペースを含んでは登録できない' do
        @user.last_name = '　'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は全角ひらがな、全角カタカナ、漢字で入力して下さい')
      end
      it 'first_nameはスペースを含んでは登録できない' do
        @user.first_name = '　'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は全角ひらがな、全角カタカナ、漢字で入力して下さい')
      end
      it 'last_name_kanaはスペースを含んでは登録できない' do
        @user.last_name_kana = '　'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナは全角カタカナで入力して下さい')
      end
      it 'first_name_kanaはスペースを含んでは登録できない' do
        @user.last_name_kana = '　'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナは全角カタカナで入力して下さい')
      end
      it 'last_nameは半角では登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は全角ひらがな、全角カタカナ、漢字で入力して下さい')
      end
      it 'first_nameは半角では登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は全角ひらがな、全角カタカナ、漢字で入力して下さい')
      end
      it 'last_name_kanaは半角では登録できない' do
        @user.last_name_kana = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナは全角カタカナで入力して下さい')
      end
      it 'first_name_kanaは半角では登録できない' do
        @user.first_name_kana = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナは全角カタカナで入力して下さい')
      end
    end
  end
end
