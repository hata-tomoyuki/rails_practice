require 'rails_helper'

describe User do
  let(:nickname) { 'testuser' }
  let(:email) { 'test@aaa.test' }
  let(:password) { 'testtest' }
  let(:user) { User.new(nickname: nickname, email: email, password: password, password_confirmation: password) }

  describe '.first' do
    before do
      create(:user, nickname: nickname, email: email)
    end

    subject { described_class.first }

    it '事前に作成した通りのユーザーが取得できること' do
      expect(subject.nickname).to eq('testuser')
      expect(subject.email).to eq('test@aaa.test')
    end
  end

  describe 'validation' do
    describe 'nickname属性' do
      describe '文字数制限の検証' do
        context 'nicknameが20文字以下の場合' do
          let(:nickname) { 'a' * 20 }

          it '有効であること' do
            expect(user.valid?).to be(true)
          end
        end

        context 'nicknameが21文字以上の場合' do
          let(:nickname) { 'a' * 21 }

          it '無効であること' do
            expect(user.valid?).to be(false)
            expect(user.errors[:nickname]).to include('is too long (maximum is 20 characters)')
          end
        end
      end

      describe 'nickname存在性の検証' do
        context 'nicknameが空の場合' do
          let(:nickname) { '' }

          it '無効であること' do
            expect(user.valid?).to be(false)
            expect(user.errors[:nickname]).to include("can't be blank")
          end
        end
      end
    end
  end
end
