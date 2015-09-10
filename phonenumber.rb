require 'pg'

class Phonenumber
  attr_accessor :label, :number
  attr_reader :id, :contact_id

  def initialize(label, nunmber, contact_id, id = nil)
    @label = label
    @number = number
    @contact_id = contact_id
    @id = id
  end

  def method_name
    
  end
end