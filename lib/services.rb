# frozen_string_literal: true

require 'sequel'
require 'safe_yaml'

module Services
  class << self
    def configure!
      load_config
    end

    def load_config
      SafeYAML::OPTIONS[:default_mode] = :safe
      @config = SafeYAML.load_file('./config/config.yaml')
    end

    def database
      @database ||= Sequel.connect(@config['database']['endpoint'])
    end

    def jwt_public_key
      gen_key if @public_key.nil?
      @public_key
    end

    def jwt_private_key
      gen_key if @private_key.nil?
      @private_key
    end

    private

    def gen_key
      @private_key = OpenSSL::PKey::RSA.generate 2048
      @public_key = @private_key.public_key
    end
  end
end
