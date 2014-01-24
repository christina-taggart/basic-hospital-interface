class Employee < ActiveRecord::Migration
	def self.change
     create_table :employees do |t|
      t.string :user
      t.string :firstname
  	end
  end
end