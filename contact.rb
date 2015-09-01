class Contact
 
  attr_accessor :name, :email, :phone_numbers

  def initialize(name, email, phone_numbers)
    @name = name
    @email = email
    @phone_numbers = phone_numbers
  end
 
  def to_s
    "#{name} (#{email}) #{phone_numbers}"
  end
 
  ## Class Methods
  class << self
    def create(name, email, phone_numbers)
      contact = Contact.new(name, email, phone_numbers)
      Contact_database.add_contact(contact)
    end

    def duplicate?(email)
      contacts_arr = Contact_database.read_all_contacts
      contacts_arr.each do |contact_ele|
        return true if contact_ele[2] == email
      end
      false
    end
 
    def find(search_term)
      contacts_arr = Contact_database.read_all_contacts
      contacts_arr.each do |contact_ele|
        if (contact_ele[1].include? search_term) || (contact_ele[2].include? search_term)
          phone_numbers = create_phone_numbers_from_csv(contact_ele)
          contact = Contact.new(contact_ele[1], contact_ele[2], phone_numbers)
          return contact
        end
      end
      false
    end
 
    def create_phone_numbers_from_csv(contact_ele)
      phone_numbers = {}
      i = 3
      while contact_ele[i] != nil do
        phone_number = contact_ele[i]
        arr = phone_number.split(":")
        label = arr[0]
        num = arr[1]
        phone_numbers[label] = num
        i += 1
      end
      phone_numbers
    end

    def all
      contacts_arr = Contact_database.read_all_contacts
      contacts_str_arr = []
      contacts_arr.each do |contact_ele|
        phone_numbers = create_phone_numbers_from_csv(contact_ele)
        contact = Contact.new(contact_ele[1], contact_ele[2], phone_numbers)
        contacts_str_arr << contact_ele[0] + ": " + contact.to_s
      end
      contacts_str_arr
    end
    
    def show(id)
      contacts_arr = Contact_database.read_all_contacts
      contacts_arr.each do |contact_ele|
        if contact_ele[0] == id
          phone_numbers = create_phone_numbers_from_csv(contact_ele)
          contact = Contact.new(contact_ele[1], contact_ele[2], phone_numbers)
          return contact
        end
      end
      false
    end
  end
end
 