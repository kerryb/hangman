module Kerryb
  class Possibilities
    def initialize words
      @words = words.dup
      @letters = ('a'..'z').to_a
    end

    def suggest_guess pattern
      regexp = /^#{pattern.gsub '_', "[#{@letters.join ''}]"}$/
      @words.reject! {|word| word !~ regexp}
      letter_counts = count_letter_appearances
      choose_letter letter_counts
    end

    def letter_used letter
      @letters.delete letter
    end

    private

    def count_letter_appearances
      letter_counts = {}
      @letters.each do |letter|
        letter_counts[letter] = count_words_containing_letter letter
      end
      return letter_counts
    end

    def count_words_containing_letter letter
      @words.select {|word| word.include? letter}.size
    end

    def choose_letter letter_counts
      sorted_letter_counts = sort_letter_counts letter_counts
      highest_count = sorted_letter_counts.last[1]
      letters_in_most_words = sorted_letter_counts.select {|letter_count| letter_count[1] == highest_count}
      if letters_in_most_words.size == 1
        letters_in_most_words.first[0]
      else
        joint_most_common_letters = letters_in_most_words.map {|letter_count| letter_count[0]}
        most_common_letter joint_most_common_letters
      end
    end

    def most_common_letter letters
      concatenated_words = @words.join('')
      letter_counts = letters.map {|letter| [letter, concatenated_words.count(letter)]}
      sorted_letter_counts = sort_letter_counts letter_counts
      sorted_letter_counts.last[0]
    end

    def sort_letter_counts letter_counts
      letter_counts.sort {|first, second| first[1] <=> second[1]}
    end
  end
end
