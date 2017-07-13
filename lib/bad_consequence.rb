# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
  
  class BadConsequence
  
    @@MAXTREASURES = 10

    def initialize(aText, someLevels)
      @text = aText
      @levels = someLevels
    end

    def getText()
      @text
    end

    def getLevels()
      @levels
    end

    def self.getMaxTreasures()
      @@MAXTREASURES
    end

  end
  
end

