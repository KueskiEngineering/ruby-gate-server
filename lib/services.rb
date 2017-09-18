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

    def jwt_public_key(site)
      key(site)[:public]
    end

    def jwt_private_key(site)
      key(site)[:private]
    end

    private

    def key(site)
      @keys ||= {}
      @keys[site] ||= generate_key
    end

    def generate_key
      priv = OpenSSL::PKey::RSA.generate 2048
      pub = priv.public_key
      {
        private: priv,
        public: pub
      }
    end
  end
end
