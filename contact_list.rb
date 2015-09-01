require_relative 'contact'
require_relative 'contact_database'

# This should be the only file where you use puts and gets
class Contact_list

  # get users input
  def self.get_user_input
    STDIN.gets.chomp
  end

  # get users phone numbers
  # def self.get_phone_num
  #   phone_num = {}
  #   while true
  #     puts "Do you have a phone number? (Y/N)"
  #     command = get_user_input
  #     case command
  #     when "Y"
  #       puts "Please input the label of the phone number now:"
  #       label = get_user_input
  #       puts "Please input the number itself now:"
  #       number = get_user_input
  #       phone_num[label] = number
  #     when "N"
  #       break
  #     else
  #       puts "Sorry I don't understand your command!"
  #     end
  #   end
  #   phone_num
  # end

  # print contact details in separate lines
  def self.puts_details(contact_ele)
    puts "Name: #{contact_ele[1]}"
    puts "Email: #{contact_ele[2]}"
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

  # create a contact
  def self.create_contact
    puts "Please input the email now:"
    email = get_user_input
    if Contact.duplicate?(email)
      puts "The contact already exists and cannot be created"
      return
    else
      puts "Please input the full name now:"
      name = get_user_input
    end

    puts Contact.create(name, email)
  end
  
  # list all contacts
  def self.list_contacts
    contacts_str_arr = Contact.all
    contacts_str_arr.each do |contact_str|
      puts contact_str
    end
  end

  # show a contact with ID
  def self.show_contact  
    contact_ele = Contact.show(ARGV[1])
    if contact_ele
      puts_details(contact_ele)
    else
      puts "Sorry we couldn't find a contact with ID #{ARGV[1]}"
    end
  end

  # find a contact with term
  def self.find_contact
    search_term = ARGV[1]
    contact_ele = Contact.find(search_term)
    if contact_ele
      puts_details(contact_ele)
    else
      puts "Sorry we couldn't find a contact with the search term #{search_term}"
    end
  end

end

Contact_list.which_command_to_execute(ARGV[0])