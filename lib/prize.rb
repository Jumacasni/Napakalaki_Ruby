# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
  
  class Prize
    def initialize(t, l)
      @treasures = t
      @level = l    
    end

    def getTreasures
      @treasures
    end

    def getLevel
      @level
    end

    def to_s
      "Tesoros ganados: #{@treasures} \n Niveles ganados: #{@level}"
    end
  end
  
end

