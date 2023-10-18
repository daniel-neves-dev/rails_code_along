require 'rails_helper'

describe 'Posts navigate' do

  before do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it 'loads successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'displays the "Posts" title' do
      expect(page).to have_content('Posts')
    end

    it 'displays multiple posts' do
      post1 = FactoryBot.build_stubbed(:post)
      post2 = FactoryBot.build_stubbed(:second_post)
      visit posts_path
      expect(page).to have_content(/Rationale|content/)

    end

    describe 'Post creation' do
      before do
        visit new_post_path
      end

      it 'loads the new post form' do
        expect(page.status_code).to eq(200)
      end

      it 'creates a post from the new form' do
        fill_in 'post[date]', with: Date.today
        fill_in 'post[rationale]', with: "Some rationale"

        click_on "Save"

        expect(page).to have_content("Some rationale")
      end

      it 'associates the post with the logged-in user' do
        fill_in 'post[date]', with: Date.today
        fill_in 'post[rationale]', with: "User Association"

        click_on "Save"

        expect(User.last.posts.last.rationale).to eq("User Association")
      end
    end
  end

  describe 'edit' do
    before do
      @post = FactoryBot.create(:post)
    end

    it 'can be reached by clicking edit on the index page' do
      visit posts_path

      edit_link = find("a[href='/posts/#{@post.id}/edit']")
      edit_link.click

      expect(page.status_code).to eq(200)
    end

    it 'can be edited' do
      visit edit_post_path(@post)

      find('input[name="post[date]"]', wait: 10).set(Date.today)
      fill_in 'post[rationale]', with: "Edited content"
      click_on "Save"

      expect(page).to have_content("Edited content")
    end
  end
end
