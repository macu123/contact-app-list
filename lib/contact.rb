class Contact < ActiveRecord::Base
  has_many :phonenumbers

  validates :firstname, :lastname, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}, uniqueness: true
end