#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "singleton"
require_relative "treasure.rb"
require_relative "monster.rb"
require_relative "treasure_kind.rb"
require_relative "prize.rb"
require_relative"specific_bad_consequence.rb"
require_relative"numeric_bad_consequence.rb"
require_relative"death_bad_consequence.rb"
require_relative "cultist.rb"

module NapakalakiGame
  
  class CardDealer
  
    include Singleton

    private

    def initTreasureCardDeck()
        @unusedTreasures = Array.new
        @usedTreasures = Array.new

        @unusedTreasures << Treasure.new("¡Sí mi amo!", 4, TreasureKind::HELMET)
        @unusedTreasures << Treasure.new("Botas de investigación", 3, TreasureKind::SHOES)
        @unusedTreasures << Treasure.new("Capucha de Cthulhu", 3, TreasureKind::HELMET)
        @unusedTreasures << Treasure.new("A prueba de babas", 2 , TreasureKind::ARMOR)
        @unusedTreasures << Treasure.new("botas de lluvia ácida", 1, TreasureKind::BOTHHANDS)
        @unusedTreasures << Treasure.new("Casco Minero", 2, TreasureKind::HELMET)
        @unusedTreasures << Treasure.new("Ametralladora ACME", 4, TreasureKind::BOTHHANDS)
        @unusedTreasures << Treasure.new("Camiseta de la ETSIIT", 1, TreasureKind::ARMOR)
        @unusedTreasures << Treasure.new("Clavo de rail ferroviario", 3, TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("Cuchillo de shushi arcano", 2, TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("Fez alópodo", 3, TreasureKind::HELMET)
        @unusedTreasures << Treasure.new("Hacha prehistórica", 2, TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("El aparato de Pr. Tesla", 4, TreasureKind::ARMOR)
        @unusedTreasures << Treasure.new("Gaita", 4, TreasureKind::BOTHHANDS)
        @unusedTreasures << Treasure.new("Insecticida", 2 , TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("Escopeta de 3 cañones", 4, TreasureKind::BOTHHANDS)
        @unusedTreasures << Treasure.new("Garabato místico", 2, TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("La rebeca metálica", 2, TreasureKind::ARMOR)
        @unusedTreasures << Treasure.new("Lanzallamas", 4, TreasureKind::BOTHHANDS)
        @unusedTreasures << Treasure.new("Necronomicón", 5, TreasureKind::BOTHHANDS)
        @unusedTreasures << Treasure.new("Linterna a 2 manos", 3, TreasureKind::BOTHHANDS)
        @unusedTreasures << Treasure.new("Necrognomicón", 2, TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("Necrotelecom", 2, TreasureKind::HELMET)
        @unusedTreasures << Treasure.new("Mazo de los antiguos", 3, TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("Necroplayboycón", 3, TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("Porra preternatural", 2, TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("Shogulador", 1, TreasureKind::BOTHHANDS)
        @unusedTreasures << Treasure.new("Varita de atizamiento", 3, TreasureKind::ONEHAND)
        @unusedTreasures << Treasure.new("Tentáculo de pega", 2, TreasureKind::HELMET)
        @unusedTreasures << Treasure.new("Zapato deja-amigos", 1, TreasureKind::SHOES)
    end

    def initMonsterCardDeck()
      @unusedMonsters = Array.new
      @usedMonsters = Array.new

      prize = Prize.new(3,1)
      bc = SpecificBadConsequence.new("Pierdes 1 mano visible",0,[TreasureKind::ONEHAND],Array.new)
      @unusedMonsters << Monster.new("El mal indecible impronunciable",10,bc,prize,-2)

      prize = Prize.new(2,1)
      bc = NumericBadConsequence.new("Pierdes todos tus tesoros visibles. Jajaja.", 0, BadConsequence.getMaxTreasures(),0)
      @unusedMonsters << Monster.new("Testigos oculares",6,bc,prize,2)

      prize = Prize.new(2,5)
      bc = DeathBadConsequence.new("Hoy no es tu día de suerte. Mueres.")
      @unusedMonsters << Monster.new("Cthulhu",20,bc,prize,4)

      prize = Prize.new(2,1)
      bc = NumericBadConsequence.new("Tu gobierno te recorta 2 niveles",2,0,0)
      @unusedMonsters << Monster.new("Serpiente Político",8,bc,prize,-2)

      prize = Prize.new(1,1)
      bc = SpecificBadConsequence.new("Pierdes tu casco y tu armadura visible. Pierdes tus manos ocultas.",0,[TreasureKind::HELMET,TreasureKind::ARMOR], [TreasureKind::BOTHHANDS])
      @unusedMonsters << Monster.new("Felpuggoth",2,bc,prize,5)

      prize = Prize.new(4,2)
      bc = NumericBadConsequence.new("Pierdes 2 niveles",2,0,0)
      @unusedMonsters << Monster.new("Shoggoth",16,bc,prize,-4)

      prize = Prize.new(1,1)
      bc = NumericBadConsequence.new("Pintalabos negro. Pierdes 2 niveles.",2,0,0)
      @unusedMonsters << Monster.new("Lolitagooth",2,bc,prize,3)

      # 3 Byakhees de bonanza
      prize = Prize.new(2,1)
      bc = SpecificBadConsequence.new("Pierdes tu armadura visible y otra oculta",0,[TreasureKind::ARMOR],[TreasureKind::ARMOR])
      @unusedMonsters << Monster.new("3 Byakhees de bonanza", 8, bc, prize)

      # Tenochtitlan
      prize = Prize.new(1,1)
      bc = SpecificBadConsequence.new("Embobados con el lindo primigenio te descartas de tu casco visible",0 ,[TreasureKind::HELMET] , Array.new)
      @unusedMonsters << Monster.new("Tenochtitlan",2, bc, prize)

      # El sopor de Dunwich
      prize = Prize.new(1,1)
      bc = SpecificBadConsequence.new("El primordial bostezo contagioso. Pierdes el calzado visible",0 ,[TreasureKind::SHOES] , Array.new)
      @unusedMonsters << Monster.new("El sopor de Dunwich",2, bc, prize)  

      # Demonios de Magaluf
      prize = Prize.new(4,1)
      bc = SpecificBadConsequence.new("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta",0,[TreasureKind::ONEHAND],[TreasureKind::ONEHAND])
      @unusedMonsters << Monster.new("Demonios de Magaluf",2, bc, prize)  

      # El gorrón en el umbral
      prize = Prize.new(3,1)
      bc = NumericBadConsequence.new("Pierdes todos tus tesoros visibles", 0, BadConsequence.getMaxTreasures(),0)
      @unusedMonsters << Monster.new("El gorrón en el umbral",13, bc, prize)

      # H.P. Munchcraft
      prize = Prize.new(2,1)
      bc = SpecificBadConsequence.new("Pierdes la armadura visible",0,[TreasureKind::ARMOR], Array.new)
      @unusedMonsters << Monster.new("H.P. Munchcraft",6, bc, prize)

      # Necrófago
      prize = Prize.new(1,1)
      bc = SpecificBadConsequence.new("Sientes bichos bajo la ropa. Descarta la armadura visible",0,[TreasureKind::ARMOR], Array.new)
      @unusedMonsters << Monster.new("Necrófago",13, bc, prize)

      # El rey de rosa 
      prize = Prize.new(3,2)
      bc = NumericBadConsequence.new("Pierdes 5 niveles y 3 tesoros visibles",5,3,0)
      @unusedMonsters << Monster.new("El rey de rosado",11,bc,prize)

      # Flecher
      prize = Prize.new(1,1)
      bc = NumericBadConsequence.new("Toses los pulmones y pierdes 2 niveles.",2,0,0)
      @unusedMonsters << Monster.new("Flecher",2,bc,prize)

      # Los hondos
      prize = Prize.new(2,1)
      bc = DeathBadConsequence.new("Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto")
      @unusedMonsters << Monster.new("Los hondos",8,bc,prize)

      # Semillas Cthulhu
      prize = Prize.new(2,1)
      bc = NumericBadConsequence.new("Pierdes 2 niveles y 2 tesoros ocultos.",2,0,2)
      @unusedMonsters << Monster.new("Semillas Cthulhu",4,bc,prize) 

      # Dameargo
      prize = Prize.new(2,1)
      bc = SpecificBadConsequence.new("Te intentas escaquear. Pierdes una mano visible",0,[TreasureKind::ONEHAND],Array.new)
      @unusedMonsters << Monster.new("Dameargo",1,bc,prize) 

      # Pollipólipo volante
      prize = Prize.new(2,1)
      bc = NumericBadConsequence.new("Da mucho asquito. Pierdes 3 niveles.",3,0,0)
      @unusedMonsters << Monster.new("Pollipólipo volante",3,bc,prize)

      # Yskhtihyssg-Goth
      prize = Prize.new(3,1)
      bc = DeathBadConsequence.new("No le hace gracia que pronuncien mal su nombre. Estas muerto")
      @unusedMonsters << Monster.new("Yskhtihyssg-Goth",14,bc,prize)

      # Familia feliz
      prize = Prize.new(3,1)
      bc = DeathBadConsequence.new("La familia te atrapa. Estás muerto.")
      @unusedMonsters << Monster.new("Familia feliz",1,bc,prize)

      # Roboggoth
      prize = Prize.new(2,1)
      bc = SpecificBadConsequence.new("La quinta directiva primaria te obliga a perder 2 niveles y un tesoro 2 manos visible",2,[TreasureKind::BOTHHANDS],Array.new)
      @unusedMonsters << Monster.new("Roboggoth",8,bc,prize)

      # El espía sordo
      prize = Prize.new(1,1)
      bc = SpecificBadConsequence.new("Te asusta en la noche. Pierdes un casco visible.",0,[TreasureKind::HELMET],Array.new)
      @unusedMonsters << Monster.new("El espía sordo",5,bc,prize)

      # Tongue
      prize = Prize.new(2,1)
      bc = NumericBadConsequence.new("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles.",2,5,0)
      @unusedMonsters << Monster.new("Tongue",19,bc,prize)

      # Bicéfalo
      prize = Prize.new(2,1)
      bc = SpecificBadConsequence.new("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.",3,[TreasureKind::ONEHAND,TreasureKind::BOTHHANDS],Array.new)
      @unusedMonsters << Monster.new("Bicéfalo",21,bc,prize)
    end

    def initCultistCardDeck()
      @unusedCultists = Array.new

      @unusedCultists << Cultist.new("Sectario",1)
      @unusedCultists << Cultist.new("Sectario",2)
      @unusedCultists << Cultist.new("Sectario",1)
      @unusedCultists << Cultist.new("Sectario",2)
      @unusedCultists << Cultist.new("Sectario",1)
      @unusedCultists << Cultist.new("Sectario",1)

    end

    def shuffleTreasures()
      @unusedTreasures.sort_by { |rand|  }
    end

    def shuffleMonsters()
      @unusedMonsters.sort_by { |rand|  }
    end

    def shuffleCultists()
      @unusedCultists.sort_by { |rand|  }
    end

    public

    def nextTreasure()
      if(@unusedTreasures.empty?)
        @unusedTreasures = @usedTreasures
        shuffleTreasures()
        @usedTreasures = @usedTreasures.clear
      end

      t = @unusedTreasures[0]
      @unusedTreasures.delete_at(0)

      return t
    end

    def nextMonster()
      if(@unusedMonsters.empty?)
        @unusedMonsters = @usedMonsters
        shuffleMonsters()
        @usedMonsters = @usedMonsters.clear
      end

      m = @unusedMonsters[0]
      @unusedMonsters.delete(m)

      return m
    end

    def nextCultist()
      if (@unusedCultists.empty?)
        initCultistCardDeck()
        shuffleCultists()
      end

      c = @unusedCultists[0]
      @unusedCultists.delete(c)

      return c
    end

    def giveTreasureBack(t)
      @usedTreasures << t
    end

    def giveMonsterBack(m)
      @usedMonsters << m
    end

    def initCards()
      initTreasureCardDeck()
      initMonsterCardDeck()
      initCultistCardDeck()
      shuffleTreasures()
      shuffleMonsters()
      shuffleCultists()
    end
  end
  
end


