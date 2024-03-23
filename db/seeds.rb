# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@user = User.create(
  email: "test@test.com",
  password: "123456",
  password_confirmation: "123456",
  first_name: "daniel",
  last_name: "oliveira"
)

10.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} - It is a long established fact that a reader.", user_id: @user.id)
end

@admin = AdminUser.create(
  email: "admin@admin.com",
  password: "123456",
  password_confirmation: "123456",
  first_name: "Admin",
  last_name: "User"
)

@user2 = User.create(
  email: "test2@test.com",
  password: "123456",
  password_confirmation: "123456",
  first_name: "maria",
  last_name: "bela"
)
