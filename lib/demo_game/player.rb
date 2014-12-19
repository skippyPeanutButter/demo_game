require_relative 'playable'

module DemoGame
  class Player
    include Playable

    attr_accessor :name, :health

    def initialize(name, health=100)
      @name = name.capitalize
      @health = health
      @treasures_found = Hash.new(0)
    end

    def self.from_csv(line)
      name, health = line.split(",")
      new(name, Integer(health))
    end

    def each_treasure
      @treasures_found.each do |name, points|
        yield(Treasure.new(name, points))
      end
    end

    def found_treasure(treasure)
      @treasures_found[treasure.name] += treasure.points
      puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
    end

    def name=(new_name)
      @name = new_name.capitalize
    end

    def <=>(player)
      player.score<=>score
    end

    def score
      @health + points
    end

    def points
      @treasures_found.values.reduce(0, :+)
    end

    def to_s
      "I'm #{@name} with health = #{@health}, points = 100, and score = #{score}"
    end
  end

  if __FILE__ == $PROGRAM_NAME
    player = Player.new("moe")
    puts player.name
    puts player.health
    player.w00t
    puts player.health
    player.blam
    puts player.health
  end
end