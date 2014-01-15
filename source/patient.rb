class Patient
  attr_reader :name, :currently_visiting, :last_visited, :medications, :med_allergies, :diagnosis

  def initialize(name)
    @name = name
    @currently_visiting = false
    @last_visited = nil
    @medications = []
    @med_allergies = []
    @diagnosis = "Currently healthy"
  end

  def is_visiting?
    @currently_visiting
  end
end