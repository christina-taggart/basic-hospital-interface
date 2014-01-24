require_relative '../app/models/Patient'
require 'csv'

module PatientImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/Patients.csv")
    field_names = nil
    Patient.transaction do
      File.open(filename).each do |line|
        data = line.chomp.split(',')
        if field_names.nil?
          field_names = data
        else
          attribute_hash = Hash[field_names.zip(data)]
          Patient = Patient.create!(attribute_hash)
        end
      end
    end
  end
end