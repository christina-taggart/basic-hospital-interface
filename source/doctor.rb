require_relative 'employee.rb'

class Doctor < Employee
  attr_reader :expertise

  def initialize(name, expertise)
    super(name)
    @expertise = expertise
  end
end