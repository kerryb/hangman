module Kerryb
  class Kerryb
    LetterScore = Struct.new :letter, :score
    class LetterScore
      def <=> other
        score <=> other.score
      end
    end

    def word_list= list
      @all_words = list
    end

    def new_game guesses_left
      @words = nil
      @letters = 'etaoinsrhldcumfpgwybvkxjqz'.split ''
    end

    def guess word, guesses_left
      @words ||= words_of_length word.length
      if word =~ /^_*$/
        guess_by__frequency
      else
        guess_by_pattern /^#{word.gsub '_', "[#{@letters.join ''}]"}$/
      end
    end

    def incorrect_guess guess
      @letters.delete guess
    end

    def correct_guess guess
      @letters.delete guess
    end

    def fail reason;end
    def game_result result, word;end

    private

    def words_of_length length
      @all_words.reject {|word| word.length != length}
    end

    def guess_by__frequency
      @letters.first
    end

    def guess_by_pattern pattern
      @words.reject! {|word| word !~ pattern}
      choose_letter
    end

    def choose_letter
      scores = @letters.map {|letter| letter_score(letter)}
      scores.max.letter
    end

    def letter_score letter
      LetterScore.new(letter, 10 * words_containing(letter) + occurences_of(letter))
    end

    def words_containing letter
      @words.select {|word| word.include? letter}.size
    end

    def occurences_of letter
      @words.join('').count letter
    end
  end
end
