require_relative 'ruby_gate'
require 'securerandom'

puts 'Runnning migrations...'
Sequel.extension :migration
Sequel::Migrator.run(
  Services.database, 'model/migrations', use_transactions: true
)
puts 'Creating site `gate-server`'
site = Gate::Controllers::Site.new('gate-server')
site.create

puts 'Creating user `gate-admin`'
user = Gate::Controllers::User.new('gate-admin')
user.create
pass = SecureRandom.hex(32)

puts "Password: #{pass}"
auth = Gate::Controllers::Auth.new(site, user, pass)
auth.register

role = Gate::Controllers::Role.new('admin', site)
role.create

puts 'Creating permission `register`'
permission = Gate::Controllers::Permission.new('register', site)
permission.create

puts 'Creating role description'
role_description = Gate::Controllers::RoleDescription.new(role, permission)
role_description.create

puts 'Assigning role'
assign = Gate::Controllers::UserRole.new(role, user)
assign.create

puts 'Finished'
