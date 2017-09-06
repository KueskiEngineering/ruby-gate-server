# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:user_role) do
      primary_key :user_role_id
      foreign_key :role_id, :role
      foreign_key :user_id, :user
      unique %i[user_id role_id]
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
      Bool     :enabled, null: false, default: true
    end
  end
end
