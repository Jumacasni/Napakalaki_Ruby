# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
  
  class Monster
    def initialize(n, cl, bc, p, lc = 0)
      @name = n
      @combatLevel = cl
      @badConsequence = bc
      @prize = p
      @levelChangeAgainstCultistPlayer = lc
    end

    def getName
      @name
    end

    def getCombatLevel
      @combatLevel
    end

    def getPrize
      @prize
    end

    def getBadConsequence
      @badConsequence
    end

    def getCombatLevelAgainstCultistPlayer()
      @combatLevel + @levelChangeAgainstCultistPlayer
    end

    def to_s
      "Nombre: #{@name} \n Nivel: #{@level} \n Prize: #{@prize.to_s} \n Bad Consequence: #{@badConsequence.to_s}"
    end

    def getLevelsGained
      @prize.getLevel()
    end

    def getTreasuresGained
      @prize.getTreasures()
    end
  end  
  
end

