# frozen_string_literal: true

require 'ant'
require_relative '../controllers/user'
require_relative '../controllers/site'

module Gate
  module Routes
    class Users < Grape::API
      include Controllers
      namespace :users do
        post do
          process_request do
            user = Controllers::User.new(params[:user])
            user.create
            user.to_h
          end
        end
      end
    end
  end
end
