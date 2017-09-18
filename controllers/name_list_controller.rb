# frozen_string_literal: true

require_relative '../lib/services'
require_relative '../lib/exception'

module Gate
  module Controllers
    ##
    # this class handles user
    class NameListController
      attr_reader :name
      def initialize(name)
        @name = name
        @dataset = Services.database[control_table].where(primary_key_hash)
        @data = @dataset.first
      end

      def exists?
        !@data.nil?
      end

      def create
        raise(already_exists_exception, @data) if exists?
        build_data
        @data[id_field] = Services.database[control_table].insert(@data)
      end

      def id
        @data[id_field]
      end

      def to_h
        @data
      end

      def ensure_exists!
        raise(not_found_exception, @name) unless exists?
      end

      def id_field
        raise(NoMethodError, 'Undefined method `id_field`')
      end

      def name_field
        raise(NoMethodError, 'Undefined method `name_field`')
      end

      def control_table
        raise(NoMethodError, 'Undefined method `control_table`')
      end

      def already_exists_exception
        raise(NoMethodError, 'Undefined method `already_exists_exception`')
      end

      def extra_fields
        {}
      end

      def not_found_exception
        raise(NoMethodError, 'Undefined method `not_found_exception`')
      end

      def primary_key_hash
        { name_field => name }
      end

      def build_data
        @data = {
          name_field => @name,
          created_at: Time.now,
          updated_at: Time.now,
          enabled: true
        }
        @data.merge!(extra_fields)
      end
    end
  end
end
