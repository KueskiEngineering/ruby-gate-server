# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:auth) do
      primary_key %i[user_id site_id]
      foreign_key :user_id, :user
      foreign_key :site_id, :site
      String   :password, null: false, size: 60
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
      Bool     :enabled, null: false, default: true
    end
  end
end
