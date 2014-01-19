class BoggleBoard
  def initialize
    @board = Array.new(4) { Array.new(4, "_")}
    @alphabet = ("A".."Z").to_a
  end

  def shake!
  @board.map! {|row, column|  @alphabet.sample }

  end

  # Defining to_s on an object controls how the object is
  # represented as a string, e.g., when you pass it to puts
  #
  # Override this to print out a sensible board format so
  # you can write code like:
  #
  # board = BoggleBoard.new
  # board.shake!
  # puts board
  def to_s
    #puts @board.each_slice(4) {|l| print l}
     #@board.map {|row| row.join(" ") + "\n" }.join + "\n"
    @board.map {|row| row.join(" ") + "\n" }.join + "\n"
  end
end

board = BoggleBoard.new
puts board
board.shake!
puts board



class BoggleBoard
  def initialize
    @board = Array.new(4){Array.new(4, "_")}
    @dice = %w[AAEEGN
            ELRTTY
            AOOTTW
            ABBJOO
            EHRTVW
            CIMOTU
            DISTTY
            EIOSST
            DELRVY
            ACHOPS
            HIMNQU
            EEINSU
            EEGHNW
            AFFKPS
            HLNNRZ
            DEILRX]
  end

  def shake!
    @board.map! do |line|
      line.map!{@dice.sample.chars.sample}
    end
  end

  # Defining to_s on an object controls how the object is
  # represented as a string, e.g., when you pass it to puts
  #
  # Override this to print out a sensible board format so
  # you can write code like:
  #
  # board = BoggleBoard.new
  # board.shake!
  # puts board
  def to_s
    @board.each{ |line| print line.join(" ") + "\n" }
  end
end


board = BoggleBoard.new
board.shake!
board.to_s






class BoggleBoard
  def initialize
    @board = Array.new(4) { Array.new(4, "_")}
    @alphabet = ("A".."Z").to_a
  end

  def shake!
  @board.map! {|row, column|  @alphabet.sample }

  end

  # Defining to_s on an object controls how the object is
  # represented as a string, e.g., when you pass it to puts
  #
  # Override this to print out a sensible board format so
  # you can write code like:
  #
  # board = BoggleBoard.new
  # board.shake!
  # puts board
  def to_s
    #puts @board.each_slice(4) {|l| print l}
     #@board.map {|row| row.join(" ") + "\n" }.join + "\n"
    @board.map {|row| row.join(" ") + "\n" }.join + "\n"
  end
end

board = BoggleBoard.new
puts board
board.shake!
puts board




class BoggleBoard
  def initialize

    #@board  = Array.new(4) { Array.new(4, "_")}#(" " * 16).split 

    # @board  = [ [""],
    #             [""],
    #             [""],
    #             [""] ]

    # @board  = [ ["", "", "", ""],
    #         ["", "", "", ""],
    #         ["", "", "", ""],
    #         ["", "", "", ""] ]

    @board = []#("_"*16).split("")
    @alphabet = ("A".."Z").to_a
   

  end


  def shake!


   
    16.times {@board << @alphabet.sample}
    @board = @board.each_slice(4).to_a

    # @board.each do |i|
    #   i.each do |j|
    #     print j
    #   end
    #   puts ""
    # end
    #@board.map! {|row, column|  @alphabet[rand(26)] }
  
  end

  # Defining to_s on an object controls how the object is
  # represented as a string, e.g., when you pass it to puts
  #
  # Override this to print out a sensible board format so
  # you can write code like:
  #
  # board = BoggleBoard.new
  # board.shake!
  # puts board
  def to_s

    @board.map {|row| row.join(" ") + "\n" }.join + "\n"
    #    @board.each do |i|
    #   i.each do |j|
    #     print j
    #   end
    #   puts ""
    # end
    
  #puts @board.each_slice(4)

  end

end


board = BoggleBoard.new
puts board
board.shake!
puts board
# board.shake!
#puts board
