require_relative 'ruby_gate'

run Rack::Cascade.new [Gate::API]
