require 'ant'
require_relative '../controllers/auth'

module Gate
  module Routes
    class Auth < Grape::API
      include Exceptions

      def self.build_auth(params)
        pass = params[:pass]
        params[:pass] = '*' * 8
        site = Controllers::Sites.new(params[:site])
        raise(SiteNotFound, params[:site]) unless site.exists?
        user = Controllers::User.new(params[:user])
        raise(UserNotFound, params[:user]) unless user.exists?
        Controllers::Auth.new(site, user, pass)
      end

      namespace :sites do
        route_param :site do
          post :register do
            process_request do
              auth = Auth.build_auth(params)
              auth.register
              auth.to_h
            end
          end

          namespace :auth do
            post do
              process_request do
                auth = Auth.build_auth(params)
                token = auth.generate_token
                token.to_h
              end
            end
          end
        end
      end
    end
  end
end
