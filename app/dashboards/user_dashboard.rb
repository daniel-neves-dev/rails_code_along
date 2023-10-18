require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    posts: Field::HasMany,
    id: Field::Number,
    email: Field::String,
    password: Field::String,
    first_name: Field::String,
    last_name: Field::String,
    remember_created_at: Field::DateTime,
    reset_password_sent_at: Field::DateTime,
    reset_password_token: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    type: Field::String,
  }.freeze


  COLLECTION_ATTRIBUTES = %i[
    posts
    id
    email
    first_name
  ].freeze


  SHOW_PAGE_ATTRIBUTES = %i[
    posts
    id
    email
    first_name
    last_name
    remember_created_at
    reset_password_sent_at
    reset_password_token
    type
    created_at
    updated_at
  ].freeze


  FORM_ATTRIBUTES = %i[
    email
    password
    first_name
    last_name
  ].freeze

end
