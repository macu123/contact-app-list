require 'pry'
require 'active_record'
require_relative 'lib/contact'
require_relative 'lib/phonenumber'
require_relative 'lib/contact_list'

ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'contact_list',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)

puts 'CONNECTED'

puts 'Setting up Database (recreating tables) ...'

ActiveRecord::Schema.define do

  unless ActiveRecord::Base.connection.table_exists?(:contacts)
    create_table :contacts do |table|
      table.column :firstname, :string
      table.column :lastname, :string
      table.column :email, :string
    end
  end
  
  unless ActiveRecord::Base.connection.table_exists?(:phonenumbers)
    create_table :phonenumbers do |table|
      table.references :contact
      table.column :label, :string
      table.column :number, :string
    end
  end
end

puts 'Setup DONE'

Contact_list.which_command_to_execute(ARGV[0])