class Hospital
  attr_reader :name, :location, :num_employees, :num_patients

  def initialize(name, location)
    @name = name
    @location = location
    @num_employees = 0
    @num_patients = 0
  end
end
