# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id

      Integer     :steam_id, unique: true
      String      :username, unique: true, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
