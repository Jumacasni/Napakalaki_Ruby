# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "numeric_bad_consequence.rb"

module NapakalakiGame
  
  class DeathBadConsequence < NumericBadConsequence
    def initialize(t)
      super(t, Player.getMaxLevel(), BadConsequence.getMaxTreasures(), BadConsequence.getMaxTreasures())
      @death = true
    end

    def getDeath
      @death
    end
  end
  
end

