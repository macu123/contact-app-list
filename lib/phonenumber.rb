class Phonenumber < ActiveRecord::Base
  belongs_to :contact
  validates :contact, presence: true
  validates :label, presence: true, inclusion: {within: ["Work", "Home", "Mobile"]}
  validates :number, presence: true, uniqueness: true, format: {with: /\A[0-9]{3} [0-9]{3} [0-9]{4}\z/}
end