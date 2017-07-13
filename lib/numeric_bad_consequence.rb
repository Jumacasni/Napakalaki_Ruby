# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "bad_consequence.rb"

module NapakalakiGame
  
  class NumericBadConsequence < BadConsequence
    def initialize(t, l, nv, nh)
      super(t, l)
      @nVisibleTreasures = nv
      @nHiddenTreasures = nh
    end

    def getNVisibleTreasures()
      @nVisibleTreasures
    end

    def getNHiddenTreasures()
      @nHiddenTreasures
    end

    def isEmpty()
      if(@nVisibleTreasures == 0 && @nHiddenTreasures == 0)
        return true
      end

      return false
    end

    def substractVisibleTreasure(t)
      if(@nVisibleTreasures != 0)
          @nVisibleTreasures = @nVisibleTreasures - 1;
      end
    end

    def substractHiddenTreasure(t)
      if(@nHiddenTreasures != 0)
          @nHiddenTreasures = @nHiddenTreasures - 1;
      end
    end

    def adjustToFitTreasureLists(v, h)
      if(@nVisibleTreasures <= v.size)
          nuevoNVisible = @nVisibleTreasures
      else
          nuevoNVisible = v.size
      end

      if(@nHiddenTreasures <= h.size)
          nuevoNHidden = @nHiddenTreasures
      else
          nuevoNHidden = h.size
      end

      bc = NumericBadConsequence.new(getText(), getLevels(), nuevoNVisible, nuevoNHidden)

      return bc
    end

    def to_s
      return "\n " + getText() + "\n Pierdes " + getLevels().to_s + " niveles\n Tesoros visibles perdidos: #{@n_visible_treasures}\n Tesoros escondidos perdidos: #{@n_hidden_treasures}\n"
    end
  end
  
end

