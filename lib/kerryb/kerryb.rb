module Kerryb
  class Kerryb
    def word_list=(list)
      @all_words = list
    end

    def new_game(guesses_left)
      @words = @all_words.dup
      @letters = ('a'..'z').to_a
    end

    def guess(word, guesses_left)
      regexp = /^#{word.gsub '_', "[#{@letters.join ''}]"}$/
      @words.reject! {|word| word !~ regexp}
      choose_letter
    end

    def incorrect_guess(guess)
      @letters.delete guess
    end

    def correct_guess(guess)
      @letters.delete guess
    end

    def fail(reason)
    end

    def game_result(result, word)
    end

    private

    def choose_letter
      winner = @letters.inject([nil, 0]) do |choice, letter|
        score = 10 * words_containing(letter) + total_occurences_of(letter)
        score > choice[1] ? [letter, score] : choice
      end
      winner[0]
    end

    def words_containing letter
      @words.select {|word| word.include? letter}.size
    end

    def total_occurences_of letter
      @words.join('').count letter
    end
  end
end
