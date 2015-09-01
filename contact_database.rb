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
    idx = CSV.readlines("contacts.csv").length + 1
    CSV.open("contacts.csv", "a") do |csv|
      data = ["#{idx}" ,"#{contact.name}", "#{contact.email}"]
      contact.phone_numbers.each do |label, number|
        data << "#{label}: #{number}"
      end
      csv << data
    end
    idx
  end

end