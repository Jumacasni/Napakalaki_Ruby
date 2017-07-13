# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "player.rb"

module NapakalakiGame
  
  class CultistPlayer < Player

    @@totalCultistPlayers = 0

    def initialize(p, c)
      super(p.getName(),1,nil,Array.new,Array.new,nil)
      copyPlayer(p)
      @myCultistCard = c
      @@totalCultistPlayers = @@totalCultistPlayers + 1
    end

    def self.getTotalCultistPlayers()
      @@totalCultistPlayers
    end

    protected

    def getCombatLevel()
      level = super
      level = level + 0.7*level
      level = level + @myCultistCard.getGainedLevels()*@@totalCultistPlayers
      level = level.to_i

      return level
    end

    def getOponentLevel(m)
      m.getCombatLevelAgainstCultistPlayer()
    end

    def shouldConvert()
      return false
    end

    def giveMeATreasure()
      numeroAleatorio = rand(0..(getVisibleTreasures().size))
      t = getVisibleTreasures()[numeroAleatorio]
      getVisibleTreasures().delete(t)
      return t
    end

    def canYouGiveMeATreasure()
      if(getVisibleTreasures().size > 0)
        return true
      end

      return false
    end
  end
 
end
