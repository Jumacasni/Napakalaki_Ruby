# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
  
  class Treasure
    def initialize(n, b, t)
      @name = n
      @bonus = b
      @type = t
    end

    def getName()
      @name
    end

    def getBonus()
      @bonus
    end

    def getType()
      @type
    end

    def to_s
      "#{@name} - Bonus: #{@bonus} - Tipo: #{@type}"
    end
  end  
  
end

