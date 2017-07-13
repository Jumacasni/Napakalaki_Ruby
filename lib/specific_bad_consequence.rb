# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "bad_consequence.rb"

module NapakalakiGame
  
  class SpecificBadConsequence < BadConsequence
    def initialize(t,l,v,h)
      super(t,l)
      @specificVisibleTreasures = v
      @specificHiddenTreasures = h
    end

    def getSpecificVisibleTreasures()
      @specificVisibleTreasures
    end

    def getSpecificHiddenTreasures()
      @specificHiddenTreasures
    end

    def isEmpty()
      if(@specificVisibleTreasures.empty? && @specificHiddenTreasures.empty?)
        return true
      end

      return false
    end

    def substractVisibleTreasure(t)
      if (!(@specificVisibleTreasures.empty?))
          @specificVisibleTreasures.delete(t.getType())
      end
    end

    def substractHiddenTreasure(t)
      if (!(@specificHiddenTreasures.empty?))
          @specificHiddenTreasures.delete(t.getType())
      end
    end

    def adjustToFitTreasureLists(v, h)
      vt = Array.new
      vh = Array.new

      v.each do |t|
          if(@specificVisibleTreasures.index(t.getType()) != nil)
            vt << t.getType()
          end
      end

      h.each do |t|
        if(@specificHiddenTreasures.index(t.getType()) != nil)
          vh << t.getType()
        end
      end

      bc = SpecificBadConsequence.new(getText(), getLevels(), vt, vh)

      return bc
    end

    def to_s
      return "\n " + getText() + "\n Pierdes " + getLevels().to_s + " niveles \n Specific visible treasures: #{@specificVisibleTreasures} \n Specific hidden treasures: #{@specificHiddenTreasures}\n"
    end
  end  
  
end

