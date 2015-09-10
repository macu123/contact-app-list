# This should be the only file where you use puts and gets
class Contact_list

  # get users input
  def self.get_user_input
    STDIN.gets.chomp
  end

  # get users phone numbers
  def self.get_phone_num(contact)
    while true
      puts "Do you have a phone number? (Y/N)"
      command = get_user_input
      case command
      when "Y"
        puts "Please input the label of the phone number now:"
        label = get_user_input
        puts "Please input the number itself now:"
        number = get_user_input
        phonenumber = contact.phonenumbers.create(label: label, number: number)
        if phonenumber.persisted?
          puts "Phone number saved!"
          next
        end

        phonenumber.errors.full_messages.each do |message|
          puts message
        end
      when "N"
        puts "Exit!"
        return
      else
        puts "Sorry I don't understand your command!"
      end
    end
  end

  # print contact details in separate lines
  def self.puts_details(contact)
    puts "First Name: #{contact.firstname}"
    puts "Last Name: #{contact.lastname}"
    puts "Email: #{contact.email}"

    puts contact.phonenumbers
    contact.phonenumbers.each do |phonenumber|
      print "#{phonenumber.label}: #{phonenumber.number} "
    end
    print "\n"
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
    puts "Please input the first name now:"
    firstname = get_user_input
    puts "Please input the last name now:"
    lastname = get_user_input
    contact = Contact.create(firstname: firstname, lastname: lastname, email: email)
    if contact.persisted?
      puts "Contact saved!"
      get_phone_num(contact)
      return
    end

    contact.errors.full_messages.each do |message|
      puts message
    end
  end
  
  # list all contacts
  def self.list_contacts
    Contact.all.each do |contact|
      puts_details(contact)
      puts "**********************************"
    end
  end

  # show a contact with ID
  def self.show_contact  
    contact = Contact.find(ARGV[1])
    puts_details(contact)
  rescue
    puts "Sorry we couldn't find a contact with ID #{ARGV[1]}"
  end

  def self.find_contact_by_firstname(search_term)
    contact = Contact.where('firstname LIKE ?', "%#{search_term}%").first
    puts_details(contact)
    true
  rescue
    puts "Sorry we couldn't find a contact with the search term #{search_term} in firstname"
    false
  end

  def self.find_contact_by_lastname(search_term)
    contact = Contact.where('lastname LIKE ?', "%#{search_term}%").first
    puts_details(contact)
    true
  rescue
    puts "Sorry we couldn't find a contact with the search term #{search_term} in lastname"
    false
  end

  def self.find_contact_by_email(search_term)
    contact = Contact.where('email LIKE ?', "%#{search_term}%").first
    puts_details(contact)
    true
  rescue
    puts "Sorry we couldn't find a contact with the search term #{search_term} in email"
    false
  end

  # find a contact with term
  def self.find_contact
    search_term = ARGV[1]
    if find_contact_by_email(search_term)
      return
    elsif find_contact_by_firstname(search_term)
      return
    else
      find_contact_by_lastname(search_term)
    end
  end
end