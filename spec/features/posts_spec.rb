require 'rails_helper'

describe 'Posts navigate' do
  describe 'index' do
    it 'reach successfully' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end

    xit 'has a Post title' do
      visit posts_path
      expect(page). to have_content(/Posts/)
    end

    describe "Post creation" do
      before do
        user =  User.create(email: "test@test.com",  password:"123456", password_confirmation:"123456",
                             first_name: "Daniel", last_name: "Oliveira" )
        login_as(user, :scope => :user)
        visit new_post_path
      end
      it 'has a new form' do
        expect(page.status_code).to eq(200)
      end

      it 'Post created from new form' do

        fill_in 'post[date]', with: Date.today
        fill_in 'post[rationale]', with: "Some rationale"

        click_on "Save"

        expect(page).to have_content("Some rationale")
      end

      it 'Post with user associated' do

        fill_in 'post[date]', with: Date.today
        fill_in 'post[rationale]', with: "User Association"

        click_on "Save"

        expect(User.last.posts.last.rationale).to eq("User Association")
      end
    end
  end
end