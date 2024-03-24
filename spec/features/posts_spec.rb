require 'rails_helper'

RSpec.describe 'Posts navigation', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:non_authorized_user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:second_post) { FactoryBot.create(:post, user: user) }

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      post
      second_post
      visit posts_path
    end

    it 'loads successfully' do
      expect(page).to have_http_status(200)
    end

    it 'displays the "Posts" title', type: :feature, js: true do
      expect(page).to have_content('Posts')
    end

    it 'displays multiple posts', type: :feature, js: true do
      expect(page).to have_content(post.rationale)
      expect(page).to have_content(second_post.rationale)
    end
  end

  describe 'Post creation' do
    before { visit new_post_path }

    it 'loads the new post form' do
      expect(page).to have_http_status(200)
    end

    it 'creates a post from the new form page', type: :feature, js: true do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some rationale'
      click_on 'Save'
      expect(page).to have_content('Some rationale')
    end

    it 'associates the post with the logged-in user', type: :feature, js: true do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'User Association'
      click_on 'Save'
      expect(user.posts.last.rationale).to eq('User Association')
    end
  end

  describe 'new' do
    it 'has a link from the homepage' do
      visit root_path
      expect(page).to have_link('New Entry')
      click_on('New Entry')
      expect(page).to have_http_status(200)
    end
  end

  describe 'edit' do
    before { post }

    it 'can be reached by clicking edit on the index page' do
      visit posts_path
      click_on 'Edit', match: :first
      expect(page).to have_http_status(200)
    end

    it 'can be edited', type: :feature, js: true do
      visit edit_post_path(post)
      fill_in 'post[rationale]', with: 'Edited content'
      click_on 'Save'
      expect(page).to have_content('Edited content')
    end

    it 'cannot be edited by non-authorized user', type: :feature, js: true do
      logout(:user)
      login_as(non_authorized_user, scope: :user)
      visit edit_post_path(post)
      expect(page).to have_current_path(root_path)
      expect(page).not_to have_content('Save')
    end
  end

  describe 'delete', type: :feature, js: true do
    before { post }

    it 'deletes the post and shows confirmation' do
      visit posts_path
      page.accept_confirm do
        click_on('Delete', match: :first)
      end
      expect(page).not_to have_content(post.rationale)
      expect(Post.exists?(post.id)).to be_falsey
    end
  end
end
