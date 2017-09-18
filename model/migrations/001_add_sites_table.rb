# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:site) do
      primary_key :site_id, auto_increment: true
      String   :name, null: false, size: 30, unique: true
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
      Bool     :enabled, null: false, default: true
    end
  end
end
