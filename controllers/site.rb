# frozen_string_literal: true

require_relative '../lib/exception'

module Gate
  module Controllers
    #
    class Site
      include Exceptions
      def initialize(site_name)
        @site = site_name
        @dataset = Services.database[:site]
                           .where(name: site_name)
        @data = @dataset.first
      end

      def exists?
        !@data.nil?
      end

      def name
        @data[:name]
      end

      def id
        @data[:site_id]
      end

      def create
        raise(SiteAlreadyExists, @data) if exists?
        @data = {
          name: @site,
          created_at: Time.now,
          updated_at: Time.now,
          enabled: true
        }
        Services.database[:site].insert(@data)
      end

      def to_h
        @data
      end
    end
  end
end
