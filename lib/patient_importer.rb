require_relative '../models/patient'
require 'csv'
require 'pry'
require 'pry-nav'

module PatientImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/patients.csv")
    field_names = nil
    Patient.transaction do
      File.open(filename).each do |line|
        data = line.chomp.split(',')
        if field_names.nil?
          field_names = data
        else
          attribute_hash = Hash[field_names.zip(data)]
          patient = Patient.create!(attribute_hash)
        end
      end
    end
  end
end