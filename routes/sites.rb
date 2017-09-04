require 'ant'
require_relative '../controllers/user'
require_relative '../controllers/site'

module Gate
  module Routes
    ##
    # Routes for handling sites
    class Sites < Grape::API
      include Controllers
      namespace :sites do
        post do
          process_request do
            site = Site.new(params[:site])
            site.create
            site.to_h
          end
        end
      end
    end
  end
end
