class Contact
 
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end
 
  def to_s
    "#{@name} (#{@email})"
  end
 
  ## Class Methods
  class << self
    def create(name, email)
      contact = Contact.new(name, email)
      Contact_database.add_contact(contact)
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
    end
 
    def all
      Contact_database.read_all_contacts
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
 