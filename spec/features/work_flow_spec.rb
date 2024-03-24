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

    it 'edit status by admin', type: :feature, js: true do
      visit edit_post_path(@post)

      choose('post_status_approved')
      click_button "Save"

      expect(@post.reload.status).to eq('approved')
    end

    it 'regular user cannot edit status', type: :feature, js: true do
      logout(:user)

      user = FactoryBot.create(:user)
      login_as(user, :scope => :user)

      visit edit_post_path(@post)

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are not authorized')
    end
  end
end