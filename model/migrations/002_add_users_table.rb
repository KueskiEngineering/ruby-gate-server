# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:user) do
      primary_key :user_id, auto_increment: true
      String   :username, null: false, size: 32, unique: true
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
      Bool     :enabled, null: false, default: true
    end
  end
end
