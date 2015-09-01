class Contact
 
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end
 
  def to_s
    "#{name} (#{email})"
  end
 
  ## Class Methods
  class << self
    def create(name, email)
      contact = Contact.new(name, email)
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
          return contact_ele
        end
      end
      false
    end
 
    def all
      contacts_arr = Contact_database.read_all_contacts
      contacts_str_arr = []
      contacts_arr.each do |contact_ele|
        contact = Contact.new(contact_ele[1], contact_ele[2])
        contacts_str_arr << contact_ele[0] + ": " + contact.to_s
      end
      contacts_str_arr
    end
    
    def show(id)
      contacts = Contact_database.read_all_contacts
      contacts.each do |contact|
        if contact[0] == id
          return contact
        end
      end
      false
    end
  end
end
 