require 'csv'

class Contact_database

  def self.read_all_contacts
    all_contacts = []
    CSV.foreach('contacts.csv') do |row|
      all_contacts << row
    end
    all_contacts
  end

  def self.add_contact(contact)
    idx = CSV.readlines("contacts.csv").length
    CSV.open("contacts.csv", "a") do |csv|
      csv << ["#{idx}" ,"#{contact.name}", "#{contact.email}"]
    end
    idx
  end

end