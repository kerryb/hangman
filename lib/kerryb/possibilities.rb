module Kerryb
  class Possibilities
    def initialize words
      @words = words
    end

    def most_common_letter
      letter_counts = count_letters_in_all_words
      find_highest_count letter_counts
    end

    private

    def count_letters_in_all_words
      concatenated_words = @words.join('')
      ('a'..'z').map {|letter| concatenated_words.count letter}
    end

    def find_highest_count letter_counts
      highest_count, winning_index = 0, 0
      letter_counts.each_with_index do |count, index|
        if count > highest_count
          winning_index = index
          highest_count = count
        end
      end
      ('a'..'z').to_a[winning_index]
    end
  end
end
