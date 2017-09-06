# frozen_string_literal: true

require 'ant'
require_relative '../controllers/site'
require_relative '../controllers/role_description'
require_relative '../controllers/user_role'

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

        route_param :site do
          namespace :permissions do
            post do
              process_request do
                site = Site.new(params[:site])
                site.ensure_exists!
                permission = Permission.new(params[:permission], site)
                permission.create
                permission.to_h
              end
            end
          end

          namespace :roles do
            post do
              process_request do
                site = Site.new(params[:site])
                site.ensure_exists!
                role = Role.new(params[:role], site)
                role.create
                role.to_h
              end
            end

            route_param :role do
              namespace :permissions do
                post do
                  process_request do
                    site = Site.new(params[:site])
                    site.ensure_exists!
                    role = Role.new(params[:role], site)
                    role.ensure_exists!
                    permission = Permission.new(params[:permission], site)
                    permission.ensure_exists!
                    role_description = RoleDescription.new(role, permission)
                    role_description.create
                    role_description.to_h
                  end
                end
              end

              namespace :assign do
                post do
                  process_request do
                    site = Site.new(params[:site])
                    site.ensure_exists!
                    role = Role.new(params[:role], site)
                    role.ensure_exists!
                    user = User.new(params[:user])
                    user.ensure_exists!
                    user_role = UserRole.new(role, user)
                    user_role.create
                    user_role.to_h
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
