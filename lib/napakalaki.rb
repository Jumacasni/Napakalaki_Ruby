# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "singleton"
require_relative "player.rb"
require_relative "card_dealer.rb"
require_relative "cultist_player.rb"

module NapakalakiGame
  
  class Napakalaki
  
    include Singleton 

    private

    def initPlayers(names)
      @players = Array.new

      names.each do |n|
        @players << Player.newPlayer(n)
      end
    end

    def nextPlayer()
      if(@currentPlayer == nil)
        posicion = rand(0..(@players.size-1))

      elsif (@currentPlayer == @players[@players.size-1])
        posicion = 0

      else
        posicion = @players.index(@currentPlayer) + 1
      end

      nextPlayer = @players[posicion]
      @currentPlayer = nextPlayer

      return nextPlayer
    end

    def nextTurnAllowed()
      if(@currentPlayer == nil)
        return true

      elsif (@currentPlayer.validState())
        return true
      end

      return false
    end

    def setEnemies()
      @players.each do |p|
        numeroAleatorio = rand(0..(@players.size - 1))
        enemy = @players[numeroAleatorio]
        while(enemy == p)
          numeroAleatorio = rand(0..(@players.size - 1))
          enemy = @players[numeroAleatorio]
        end

        p.setEnemy(enemy)
      end
    end

    public 

    def developCombat()
      combatResult = @currentPlayer.combat(@currentMonster)
      @dealer.giveMonsterBack(@currentMonster)

      if combatResult == CombatResult::LOSEANDCONVERT
        cultist = @dealer.nextCultist()

        cultistPlayer = CultistPlayer.new(@currentPlayer, cultist)

        @players.each do |p|
          if(p.getEnemy() == @currentPlayer)
            p.setEnemy(cultistPlayer)
          end
        end

        indice = @players.index(@currentPlayer);
        @players.delete_at(indice)
        @players.insert(indice, cultistPlayer)

        @currentPlayer = cultistPlayer
      end

      return combatResult
    end

    def discardVisibleTreasures(treasures)
      treasures.each do |t|
        @currentPlayer.discardVisibleTreasure(t)
        @dealer.giveTreasureBack(t)
      end
    end

    def discardHiddenTreasures(treasures)
      treasures.each do |t|
        @currentPlayer.discardHiddenTreasure(t)
        @dealer.giveTreasureBack(t)
      end
    end

    def makeTreasuresVisible(treasures)
      treasures.each do |t|
        @currentPlayer.makeTreasureVisible(t)
      end
    end

    def initGame(players)
      @dealer = CardDealer.instance
      initPlayers(players)
      setEnemies()
      @dealer.initCards()
      nextTurn()
    end

    def getCurrentPlayer()
      @currentPlayer
    end

    def getCurrentMonster()
      @currentMonster
    end

    def nextTurn()
      stateOK = nextTurnAllowed()

      if(stateOK)
        @currentMonster = @dealer.nextMonster()
        @currentPlayer = nextPlayer()
        dead = @currentPlayer.isDead()

        if(dead)
          @currentPlayer.initTreasures()
        end
      end

      return stateOK
    end

    def endOfGame(result)
      if(result == CombatResult::WINGAME)
        return true
      end

      return false
    end

  end
  
end

