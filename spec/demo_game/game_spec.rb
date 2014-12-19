require 'demo_game/game'

module DemoGame
  describe Game do

    before do
      @game = Game.new("FinalFantasy")

      @initial_health = 100
      @player = Player.new("moe", @initial_health)

      @game.add_player(@player)
    end

    it 'w00ts the player if die rolls a high number' do
      Die.any_instance.stub(:roll).and_return(5)

      @game.play(2)
      @player.health.should == @initial_health + (15 * 2)
    end

    it 'leaves the health unchanged if die roll is a medium number' do
      Die.any_instance.stub(:roll).and_return(3)

      @game.play(2)
      @player.health.should == @initial_health
    end

    it 'blams the player if die roll is a low number' do
      Die.any_instance.stub(:roll).and_return(1)

      @game.play(2)
      @player.health.should == @initial_health - (10 * 2)
    end

    context "in a collection of players" do
      before do
        @player1 = Player.new("moe", 100)
        @player2 = Player.new("larry", 200)
        @player3 = Player.new("curly", 300)

        @players = [@player1, @player2, @player3]
      end

      it "is sorted by decreasing score" do
        @players.sort.should == [@player3, @player2, @player1]
      end
    end

    it "assigns a treasure for points during a player's turn" do
      game = Game.new("Knuckleheads")
      player = Player.new("moe")

      game.add_player(player)

      game.play(1)

      player.points.should_not be_zero

      # or use alternate expectation syntax:
      # expect(player.points).not_to be_zero
    end

    it "computes total points as the sum of all player points" do
      game = Game.new("Knuckleheads")

      player1 = Player.new("moe")
      player2 = Player.new("larry")

      game.add_player(player1)
      game.add_player(player2)

      player1.found_treasure(Treasure.new(:hammer, 50))
      player1.found_treasure(Treasure.new(:hammer, 50))
      player2.found_treasure(Treasure.new(:crowbar, 400))

      game.total_points.should == 500
    end
  end
end