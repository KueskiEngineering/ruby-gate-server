# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:role) do
      primary_key :role_id
      foreign_key :site_id, :site
      unique %i[site_id name]
      String   :name, null: false, size: 30
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
      Bool     :enabled, null: false, default: true
    end
  end
end
