require_relative 'auditable'

module DemoGame
  class Die
    include Auditable
    attr_reader :number

    def initialize
      roll
    end

    def roll
      @number = rand(6)
      audit
      @number
    end
  end
end
