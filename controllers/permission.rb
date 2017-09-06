# frozen_string_literal: true

require_relative '../lib/services'
require_relative '../lib/exception'
require_relative 'name_list_controller'

module Gate
  module Controllers
    ##
    # this class handles user
    class Permission < NameListController
      include Exceptions
      def initialize(name, site)
        @site = site
        super(name)
      end

      def id_field
        :permission_id
      end

      def name_field
        :name
      end

      def control_table
        :permission
      end

      def extra_fields
        { site_id: @site.id }
      end

      def primary_key_hash
        { name_field => name, site_id: @site.id }
      end

      def already_exists_exception
        PermissionAlreadyExists
      end
    end
  end
end
