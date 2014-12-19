require 'demo_game/player'
require 'demo_game/treasure_trove'

module DemoGame
  describe Player do
    before do
      @health = 150
      @player = Player.new("larry", @health)
      # Have puts statements printed out to a string object instead of console during
      # spec tests.
      $stdout = StringIO.new
    end

    it 'has a capitalized name' do
      @player.name.should == "Larry"
    end

    it 'has an initial health' do
      @player.health.should == 150
    end

    it "has a string representation" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.to_s.should == "I'm Larry with health = 150, points = 100, and score = 250"
    end

    it "computes a score as the sum of its health and points" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.score.should == 250
    end

    it 'increases health by 15 when w00ted' do
      @player.w00t
      @player.health.should == @health + 15
    end

    it 'decreases health by 10 when blammed' do
      @player.blam
      @player.health.should == @health - 10
    end

    context 'created with health greater than 100' do
      before do
        @initial_health = 150
        @player = Player.new("larry", @initial_health)
      end

      it 'health is greater than 150, player is strong' do
        @player.should be_strong
      end
    end

    context 'created with health less than or equal to 100' do
      before do
        @initial_health = 100
        @player = Player.new("larry", @initial_health)
      end

      it 'player is wimpy' do
        @player.should_not be_strong
      end
    end

    it "computes points as the sum of all treasure points" do
      @player.points.should == 0

      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.points.should == 50

      @player.found_treasure(Treasure.new(:crowbar, 400))

      @player.points.should == 450

      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.points.should == 500
    end

    it "yields each found treasure and its total points" do
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))

      yielded = []
      @player.each_treasure do |treasure|
        yielded << treasure
      end

      yielded.should == [
          Treasure.new(:skillet, 200),
          Treasure.new(:hammer, 50),
          Treasure.new(:bottle, 25)
      ]
    end

    it "can be created from a CSV string" do
      player = Player.from_csv("larry,150")

      player.name.should == "Larry"
      player.health.should == 150
    end
  end
end