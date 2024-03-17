require 'rails_helper'

describe 'navigate workflow', type: :feature, js: true do

  before do
    @admin_user = FactoryBot.create(:admin_user)
    login_as(@admin_user, :scope => :user)
  end

  describe 'edit', type: :feature, js: true do
    before do
      @post = FactoryBot.create(:post)
    end

    it 'edit status', type: :feature, js: true do
      visit edit_post_path(@post)

      choose('post_status_approved')
      click_button "Save"

      expect(@post.reload.status).to eq('approved')
    end
  end
end