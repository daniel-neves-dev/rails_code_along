require 'rails_helper'

describe 'Posts navigate', true do

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

    it 'displays the "Posts" title', type: :feature, js: true do
      expect(page).to have_content('Posts')
    end

    it 'displays multiple posts', type: :feature, js: true do
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

      it 'creates a post from the new form', type: :feature, js: true do
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

  describe 'new' do
    it 'has a link from the homepage' do
      visit root_path

      click_on("New Entry")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'edit' do
    before do
      @post = FactoryBot.create(:post, user: @user)
    end


    it 'can be reached by clicking edit on the index page' do
      visit posts_path

      edit_link = find("a[href='/posts/#{@post.id}/edit']")
      edit_link.click

      expect(page.status_code).to eq(200)
    end

    it 'can be edited', :feature, js: true do
      visit edit_post_path(@post)

      find('input[name="post[date]"]', wait: 10).set(Date.today)
      fill_in 'post[rationale]', with: "Edited content"
      click_on "Save"

      expect(page).to have_content("Edited content")
    end

    it 'cannot be edited by non_authorized user' do
      logout(:user)
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(@post)
      expect(current_path).to eq(root_path)
    end
  end

  describe 'delete', type: :feature, js: true do
    it 'destroys the post and shows confirmation' do
      @post = FactoryBot.create(:post)
      visit posts_path

      page.accept_confirm do
        click_button('Delete')
      end

      expect(page).to have_content('Post was successfully deleted.')
    end
  end

end

