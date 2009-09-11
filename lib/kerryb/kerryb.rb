require 'kerryb/possibilities'

module Kerryb
  class Kerryb
    def word_list=(list)
      @word_list = list
    end

    def new_game(guesses_left)
      @possibilities = Possibilities.new @word_list
    end

    def guess(word, guesses_left)
      @possibilities.suggest_guess word
    end

    def incorrect_guess(guess)
      @possibilities.letter_used guess
    end

    def correct_guess(guess)
      @possibilities.letter_used guess
    end

    def fail(reason)
    end

    def game_result(result, word)
    end
  end
end
