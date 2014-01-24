require_relative '../models/employee'
require 'csv'

module EmployeeImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/employees.csv")
    field_names = nil
    Employee.transaction do
      File.open(filename).each do |line|
        data = line.chomp.split(',')
        if field_names.nil?
          field_names = data
        else
          attribute_hash = Hash[field_names.zip(data)]
          employee = Employee.create!(attribute_hash)
        end
      end
    end
  end
end