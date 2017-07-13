# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "dice.rb"
require_relative "combat_result.rb"

module NapakalakiGame
  
  class Player

    @@MAXLEVEL = 10

    def initialize(n, l, ht, vt, e, pbc)
      @name = n
      @level = l
      @dead = true
      @canISteal = true
      @hiddenTreasures = ht
      @visibleTreasures = vt
      @enemy = e
      @pendingBadConsequence = pbc
    end

    def copyPlayer(p)
      @name = p.getName()
      @level = p.getLevels()
      @dead = p.isDead()
      @canISteal = p.canISteal()
      @enemy = p.getEnemy()
      @hiddenTreasures = p.getHiddenTreasures() 
      @visibleTreasures = p.getVisibleTreasures()
      @pendingBadConsequence = p.getPendingBadConsequence()
    end

    private

    def bringToLife()
      @dead = false
    end

    def incrementLevels(l)
      if(@level + l >= 10)
        @level = 10

      else
        @level += l

      end
    end

    def decrementLevels(l)
      if(@level - l <= 1)
        @level = 1

      else
        @level -= l

      end
    end

    def setPendingBadConsequence(b)
      @pendingBadConsequence = b
    end

    def applyPrize(m)
      nLevels = m.getLevelsGained()
      incrementLevels(nLevels)
      nTreasures = m.getTreasuresGained()

      if(nTreasures > 0)
        dealer = CardDealer.instance

        for i in 0..nTreasures
          t = dealer.nextTreasure()
          @hiddenTreasures << t
        end
      end
    end

    def applyBadConsequence(m)
      badConsequence = m.getBadConsequence()
      nLevels = badConsequence.getLevels()
      decrementLevels(nLevels)
      pendingBad = badConsequence.adjustToFitTreasureLists(@visibleTreasures, @hiddenTreasures)
      setPendingBadConsequence(pendingBad)
    end

    def canMakeTreasureVisible(t)
      sePuede = true

        if(t.getType() == TreasureKind::ONEHAND)
          if(howManyVisibleTreasures(t.getType()) > 1 || howManyVisibleTreasures(TreasureKind::BOTHHANDS) > 0)
            sePuede = false
          end
        elsif (t.getType() == TreasureKind::BOTHHANDS)
          if(howManyVisibleTreasures(t.getType()) > 0 || howManyVisibleTreasures(TreasureKind::ONEHAND) > 0)
            sePuede = false
          end
        elsif (howManyVisibleTreasures(t.getType()) > 0)
          sePuede = false
        end

        return sePuede
    end

    def howManyVisibleTreasures(tk)
      n = 0

      @visibleTreasures.each do |t|
        if(t.getType() == tk)
          n += 1
        end
      end

      return n
    end

    def dieIfNoTreasures()
      if(@hiddenTreasures.empty? && @visibleTreasures.empty?)
        @dead = true
      end
    end

    def haveStolen()
      @canISteal = false
    end

    protected

    def getOponentLevel(m)
      m.getCombatLevel()
    end

    def shouldConvert()
      dice = Dice.instance
      number = dice.nextNumber();

      if(number == 6)
        return true
      end

      return false
    end

    def getCombatLevel()
      nivel = @level

      @visibleTreasures.each do |t|
        nivel += t.getBonus()
      end

      return nivel
    end

    def self.getMaxLevel()
      @@MAXLEVEL
    end

    public 

    def self.newPlayer(n)
      new(n, 1, Array.new, Array.new, nil, nil)
    end

    def getName()
      @name
    end

    def isDead()
      @dead
    end

    def getHiddenTreasures()
      @hiddenTreasures
    end

    def getVisibleTreasures()
      @visibleTreasures
    end

    def getPendingBadConsequence()
      @pendingBadConsequence
    end

    def getEnemy()
      @enemy
    end

    def canYouGiveMeATreasure()
      return @hiddenTreasures.size() > 0
    end

    def combat(m)
      myLevel = getCombatLevel()
      monsterLevel = getOponentLevel(m)

      if(!@canISteal)
        dice = Dice.instance
        number = dice.nextNumber()

        if(number < 3)
          enemyLevel = @enemy.getCombatLevel()
          monsterLevel = monsterLevel + enemyLevel
        end 
      end

      if(myLevel > monsterLevel)
          applyPrize(m)

          if(@level > @@MAXLEVEL)
            combatResult = CombatResult::WINGAME

          else
            combatResult = CombatResult::WIN
          end

        else
          applyBadConsequence(m)

          if(shouldConvert())
            combatResult = CombatResult::LOSEANDCONVERT

          else
            combatResult = CombatResult::LOSE
          end
        end

      return combatResult
    end

    def makeTreasureVisible(t)
      canI = canMakeTreasureVisible(t)

      if(canI)
        @visibleTreasures << t
        @hiddenTreasures.delete(t)
      end
    end

    def discardVisibleTreasure(t)
      @visibleTreasures.delete(t)
      if(@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty())
        @pendingBadConsequence.substractVisibleTreasure(t)
      end

      dieIfNoTreasures()
    end

    def discardHiddenTreasure(t)
      @hiddenTreasures.delete(t)
      if(@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty())
        @pendingBadConsequence.substractHiddenTreasure(t)
      end

      dieIfNoTreasures()
    end

    def initTreasures()
      dealer = CardDealer.instance
      dice = Dice.instance
      bringToLife()
      treasure = dealer.nextTreasure()
      @hiddenTreasures << treasure
      number = dice.nextNumber()

      if(number > 1)
        treasure = dealer.nextTreasure()
        @hiddenTreasures << treasure
      end

      if(number == 6)
        treasure = dealer.nextTreasure()
        @hiddenTreasures << treasure
      end
    end

    def validState()
      if(@pendingBadConsequence != nil)
        return @pendingBadConsequence.isEmpty() && @hiddenTreasures.size <= 4
      else 
        return @hiddenTreasures.size <= 4
      end
    end

    def getLevels()
      return @level
    end

    def stealTreasure()
      canI = canISteal()
      treasure = nil

      if(canI)
        canYou = @enemy.canYouGiveMeATreasure()

        if(canYou)
          treasure = @enemy.giveMeATreasure()
          @hiddenTreasures << treasure
          haveStolen()
        end
      end

      return treasure
    end

    def setEnemy(enemy)
      @enemy = enemy
    end

    def giveMeATreasure()
      posicion = rand(0..(@hiddenTreasures.size-1))

      t = @hiddenTreasures[posicion]
      @hiddenTreasures.delete(posicion)

      return t
    end

    def discardAllTreasures()
      copiaVisible = Array.new(@visibleTreasures)
      copiaHidden = Array.new(@hiddenTreasures)

      for i in 0..copiaVisible.size
        treasure = copiaVisible[i]
        discardVisibleTreasure(treasure)
      end

      for i in 0..copiaHidden.size
        treasure = copiaHidden[i]
        discardHiddenTreasure(treasure)
      end
    end

    def canISteal
      @canISteal
    end

    def to_s

      s = ""
      s += "Nombre: #{@name}\n"
      s += "(Nivel: #{@level})\nDead: #{@dead} - Puede robar: #{@canISteal}\n "
      s += "Enemigo: #{@enemy.getName()}"

      if(@pendingBadConsequence != nil)
        s += "\nPending Bad Consequence: #{@pendingBadConsequence.to_s}"
      end

      return s;
    end
  end 
  
end

