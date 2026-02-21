require 'rails_helper'

describe User do
  let(:nickname) { 'testuser' }
  let(:email) { "test_#{SecureRandom.hex(4)}@aaa.test" }
  let(:password) { 'testtest' }
  let(:user) { User.new(nickname: nickname, email: email, password: password, password_confirmation: password) }

  describe '.first' do
    before do
      @user = create(:user, nickname: nickname, email: email)
      @post  = create(:post, title: 'タイトル', content: '本文', user_id: @user.id)
    end

    subject { User.find(@user.id) }

    it '事前に作成した通りのユーザーが取得できること' do
      expect(subject.nickname).to eq('testuser')
      expect(subject.email).to eq(@user.email)
    end

    it 'ユーザーが持つ投稿が取得できること' do
      expect(subject.posts.size).to eq(1)
      expect(subject.posts.first.title).to eq('タイトル')
      expect(subject.posts.first.content).to eq('本文')
      expect(subject.posts.first.user_id).to eq(@user.id)
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
            expect(user.errors[:nickname]).to include('は20文字以下に設定して下さい。')
          end
        end
      end

      describe 'nickname存在性の検証' do
        context 'nicknameが空の場合' do
          let(:nickname) { '' }

          it '無効であること' do
            expect(user.valid?).to be(false)
            expect(user.errors[:nickname]).to include("が入力されていません。")
          end
        end
      end
    end
  end
end
