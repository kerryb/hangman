module Kerryb
  class Possibilities
    def initialize words
      @words = words.dup
      @letters = ('a'..'z').to_a
    end

    def suggest_guess pattern
      regexp = /^#{pattern.gsub '_', "[#{@letters.join ''}]"}$/
      @words.reject! {|word| word !~ regexp}
      choose_letter
    end

    def letter_used letter
      @letters.delete letter
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
