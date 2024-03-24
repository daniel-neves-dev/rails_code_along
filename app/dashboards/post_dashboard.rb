require "administrate/base_dashboard"

class PostDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    id: Field::Number.with_options(searchable: false ),
    date: Field::Date.with_options(searchable: true,  searchable_fields: ['date'] ),
    rationale: Field::Text.with_options(searchable: true, searchable_fields: ['rationale'] ),
    user: Field::BelongsTo.with_options(searchable: false),
    created_at: Field::DateTime.with_options(searchable: true, searchable_fields: ['created_at'] ),
    updated_at: Field::DateTime.with_options(searchable: false ),
    status: Field::Select.with_options(searchable: true ),
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    user
    status
    date
    rationale
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    user
    status
    date
    rationale
    created_at
    updated_at

  ].freeze

  FORM_ATTRIBUTES = %i[
    date
    rationale
    user
    status
  ].freeze

  COLLECTION_FILTERS = {}.freeze

end
