# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:role_description) do
      primary_key :role_description_id
      foreign_key :role_id, :role
      foreign_key :permission_id, :permission
      unique %i[role_id permission_id]
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
      Bool     :enabled, null: false, default: true
    end
  end
end
