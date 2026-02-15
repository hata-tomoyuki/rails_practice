require 'rails_helper'

RSpec.describe 'Home', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'トップページ' do
    it 'Techlogという文字列が表示される' do
      visit '/'

      expect(page).to have_content('Techlog')
    end
  end
end
