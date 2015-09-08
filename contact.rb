require 'pg'

class Contact

  attr_accessor :firstname, :lastname, :email
  attr_reader :id

  def initialize(firstname, lastname, email, id = nil)
    @firstname = firstname
    @lastname = lastname
    @email = email
    @id = id
  end

  def save
    if persisted?
      sql = "UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id = #{id};"
    else
      sql = "INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3);"
    end
    self.class.connection.exec_params(sql, [firstname, lastname, email])
    @id = self.class.find_by_email(email).id
    true
  rescue PG::Error
    false
  end

  def destroy
    sql = "DELETE FROM contacts WHERE id = $1;"
    self.class.connection.exec_params(sql, [id])
    self
  end

  def persisted?
    !id.nil?
  end
 
  ## Class Methods
  class << self
    def find(id)
      sql = "SELECT * FROM contacts WHERE id = $1;"
      connection.exec_params(sql, [id]) do |response|
        result = response.values[0]
        Contact.new(result[1], result[2], result[3], result[0])
      end
    rescue PG::Error
      nil
    end

    def find_all_by_lastname(name)
      contacts = []

      sql = "SELECT * FROM contacts WHERE lastname = $1;"
      connection.exec_params(sql, [name]) do |response|
        response.values.each do |row|
          contacts << Contact.new(row[1], row[2], row[3], row[0])
        end
      end
      contacts
    end

    def find_all_by_firstname(name)
      contacts = []

      sql = "SELECT * FROM contacts WHERE firstname = $1;"
      connection.exec_params(sql, [name]) do |response|
        response.values.each do |row|
          contacts << Contact.new(row[1], row[2], row[3], row[0])
        end
      end
      contacts
    end

    def find_by_email(email)
      sql = "SELECT * FROM contacts WHERE email = $1;"
      connection.exec_params(sql, [email]) do |response|
        result = response.values[0]
        Contact.new(result[1], result[2], result[3], result[0])
      end
    rescue PG::Error
      nil
    end

    def connection
      conn = PG.connect(
        host: 'localhost',
        dbname: 'contact_list',
        user: 'development',
        password: 'development'
        )
    end
  end
end