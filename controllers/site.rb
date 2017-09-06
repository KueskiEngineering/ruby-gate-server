# frozen_string_literal: true

require_relative '../lib/exception'
require_relative 'name_list_controller'

module Gate
  module Controllers
    #
    class Site < NameListController
      include Exceptions
      def id_field
        :site_id
      end

      def name_field
        :name
      end

      def control_table
        :site
      end

      def already_exists_exception
        SiteAlreadyExists
      end

      def not_found_exception
        SiteNotFound
      end
    end
  end
end
