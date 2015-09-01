require_relative 'contact'
require_relative 'contact_database'

# This should be the only file where you use puts and gets
class Contact_list

  # get users input
  def self.get_user_input
    STDIN.gets.chomp
  end

  # determine which command to execute
  def self.which_command_to_execute(command)
    case command
    when "help" then help_menu
    when "new" then create_contact
    when "list" then list_contacts
    when "show" then show_contact
    when "find" then find_contact
    end
  end

  # helper menu
  def self.help_menu
    puts "Here is a list of available commands:"
    puts "new - Create a new contact"
    puts "list - List all contacts"
    puts "show - Show a contact"
    puts "find - Find a contact"
  end

  def self.create_contact
    puts "Please input the full name now:"
    name = get_user_input
    puts "Please input the email now:"
    email = get_user_input

    #create a contact
    puts Contact.create(name, email)
  end

  def self.list_contacts
    # list all contacts
    contacts = Contact.all
    contacts.each do |contact|
      puts contact.inspect
    end
  end

  # show a contact with ID
  def self.show_contact  
    contact = Contact.show(ARGV[1])
    if contact
      puts "Name: #{contact[1]}"
      puts "email: #{contact[2]}"
    else
      puts "Sorry we couldn't find a contact with ID #{ARGV[1]}"
    end
  end

  def self.find_contact
    # find a contact with term
    Contact.find(ARGV[1])
  end

end

Contact_list.which_command_to_execute(ARGV[0])