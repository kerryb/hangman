module Kerryb
  class Possibilities
    attr_reader :words

    def initialize words
      @words = words.dup
      @letters = ('a'..'z').to_a
    end

    def narrow_down pattern
      regexp = /^#{pattern.gsub '_', '.'}$/
      @words.reject! {|word| word !~ regexp}
    end

    def suggest_guess
      letter_counts = count_letter_appearances
      find_highest_count letter_counts
    end

    def letter_used letter
      @letters.delete letter
    end

    private

    def count_letter_appearances
      @letters.map {|letter| @words.select {|word| word.include? letter}.size}
    end

    def find_highest_count letter_counts
      highest_count, winning_index = 0, 0
      letter_counts.each_with_index do |count, index|
        if count > highest_count
          winning_index = index
          highest_count = count
        end
      end
      @letters.to_a[winning_index]
    end
  end
end
