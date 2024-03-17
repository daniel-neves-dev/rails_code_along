require "administrate/base_dashboard"

class AdminUserDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    posts: Field::HasMany.with_options(searchable: false ),
    id: Field::Number.with_options(searchable: false ),
    email: Field::String.with_options(searchable: true ),
    password: Field::String.with_options(searchable: false ),
    first_name: Field::String.with_options(searchable: true ),
    last_name: Field::String.with_options(searchable: true ),
    remember_created_at: Field::DateTime.with_options(searchable: false ),
    reset_password_sent_at: Field::DateTime.with_options(searchable: false ),
    reset_password_token: Field::String.with_options(searchable: false ),
    created_at: Field::DateTime.with_options(searchable: false ),
    updated_at: Field::DateTime.with_options(searchable: false ),
    type: Field::String.with_options(searchable: false ),
  }.freeze


  COLLECTION_ATTRIBUTES = %i[
    posts
    email
    first_name
  ].freeze


  SHOW_PAGE_ATTRIBUTES = %i[
    posts
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
    type
  ].freeze

end
