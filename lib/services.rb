require 'sequel'
require 'safe_yaml'

SafeYAML::OPTIONS[:deserialize_symbols] = true

module Services
  class << self
    def initialize
      load_config
    end

    def load_config
      @config = SafeYAML.load_file('./config/config.yaml')
    end

    def database
      @database ||= Sequel.connect(@config[:database][:endpoint])
    end
  end
end
