# frozen_string_literal: true

module Gate
  module Controllers
    class RelationshipController < NameListController
      def initialize(main, second)
        @main = main
        @second = second
        @dataset = Services.database[control_table]
                           .where(main_field => main.id)
                           .where(second_field => second.id)
        @data = @dataset.first
      end

      def build_data
        @data = {
          main_field => @main.id,
          second_field => @second.id,
          created_at: Time.now,
          updated_at: Time.now,
          enabled: true
        }
        @data.merge!(extra_fields)
      end

      def to_h
        data = @data.clone
        data[main_field] = @main.to_h
        data[second_field] = @second.to_h
        data
      end
    end
  end
end
