require 'rails_helper'

describe 'Posts navigate' do

  before do
    @user = User.create(
      email: "test@test.com",
      password: "123456",
      password_confirmation: "123456",
      first_name: "Daniel",
      last_name: "Oliveira"
    )

    login_as(@user, scope: :user)
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
      post1 = Post.create(date: Date.today, rationale: "Post1", user_id: @user.id)
      post2 = Post.create(date: Date.today, rationale: "Post2", user_id: @user.id)
      visit posts_path
      expect(page).to have_content(/Post1|Post2/)

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
end
