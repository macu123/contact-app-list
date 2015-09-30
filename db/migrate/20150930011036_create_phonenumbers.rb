class CreatePhonenumbers < ActiveRecord::Migration
  def change
    create_table :phonenumbers do |t|
      t.references :contact
      t.string :label
      t.string :number
      t.timestamps
    end
  end
end