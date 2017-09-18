require 'ant'
require_relative '../controllers/auth'

module Gate
  module Routes
    class Auth < Grape::API
      include Exceptions

      def self.build_auth(params)
        pass = params[:pass]
        params[:pass] = '*' * 8
        site = Controllers::Site.new(params[:site])
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
                token = auth.generate_token(params[:site])
                token.to_h
              end
            end

            post :pub_key do
              process_request do
                token = token_from_request('gate-server')
                token.transaction(role: 'service', raise: true) do
                  Services.jwt_public_key(params[:site]).to_pem
                end
              end
            end
          end
        end
      end
    end
  end
end
