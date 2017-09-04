require 'grape'
require 'ant'

require_relative 'routes/auth'
require_relative 'routes/sites'
require_relative 'routes/users'
require_relative 'lib/services'

Services.configure!

module Gate
  ##
  #
  class API < Grape::API
    version('v1', using: :header, vendor: :udeg)
    prefix(:api)
    format(:json)
    helpers Ant::Response

    mount Routes::Auth
    mount Routes::Users
    mount Routes::Sites

    get :me do
      process_request do
        body_params = JSON.parse(request.body.read, symbolize_names: true)
        token = body_params[:token] || params[:token]
        params[:token] = '*' * 8
        Controllers::Token.parse(token).to_h
      end
    end
  end
end
