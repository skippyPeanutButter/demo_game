require_relative 'player'
require_relative 'die'
require_relative 'game_turn'

module DemoGame
  class Game
    attr_reader :title

    def initialize(title)
      @title = title.capitalize
      @players = []
    end

    def high_score_entry(player)
      "#{player.name.ljust(20, ".")} #{player.score}"
    end

    def load(from_file)
      File.readlines(from_file).each do |line|
        add_player(Player.from_csv(line))
      end
    end

    def save(to_file="save_game.txt")
      File.open(to_file, "w") do |file|
        file.puts "\n#{@title} High Scores:"
        @players.sort.each do |player|
          file.puts high_score_entry(player)
        end
      end
    end

    def add_player(player)
      @players << player
    end

    def total_points
      @players.inject(0) { |sum, player| sum += player.points }
    end

    def play(rounds)
      puts "There are #{@players.size} players in #{@title}"

      @players.each do |player|
        puts player
      end

      treasures = TreasureTrove::TREASURES
      puts "\nThere are #{treasures.size} treasures to be found:"
      treasures.each do |treasure|
        puts "A #{treasure.name} is worth #{treasure.points} points"
      end

      1.upto(rounds) do |round|
        puts "\nRound: #{round}"
        if block_given?
          break if yield
        end
        @players.each do |player|
          GameTurn.take_turn(player)
        end
      end
    end

    def print_name_and_health(player)
      puts "#{player.name} (#{player.health})"
    end

    def print_stats
      puts "\n#{@title} statistics:"
      puts "#{total_points} total points from treasures found"

      @players.each do |player|
        puts "\n#{player.name}'s point totals:"
        player.each_treasure do |treasure|
          puts "#{treasure.points} total #{treasure.name} points"
        end
        puts "#{player.points} grand total points"
      end

      puts "\nStrong:"
      @players.each do |p|
        print_name_and_health(p) if p.strong?
      end
      puts "\nWimpy:"
      @players.each do |p|
        print_name_and_health(p) if !p.strong?
      end

      puts "\n#{@title} High Scores:"
      @players.sort.each do |player|
        puts high_score_entry(player)
      end
    end
  end
end