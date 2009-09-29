module Kerryb
  class Kerryb
    LetterScore = Struct.new :letter, :score do
      def <=> other
        score <=> other.score
      end
    end

    def word_list= list
      @all_words = list
    end

    def new_game _
      @words = nil
      @letters = 'etaoinsrhldcumfpgwybvkxjqz'.split ''
    end

    def guess word, _
      @words ||= words_of_length word.length
      if word =~ /^_*$/
        guess_by_frequency
      else
        guess_by_pattern /^#{word.gsub '_', "[#{@letters.join ''}]"}$/
      end
    end

    def incorrect_guess guess
      @letters.delete guess
    end
    alias :correct_guess :incorrect_guess

    def fail *_;end
    def game_result *_;end

    private

    def words_of_length length
      @all_words.reject {|word| word.length != length}
    end

    def guess_by_frequency
      @letters.first
    end

    def guess_by_pattern pattern
      @words.reject! {|word| word !~ pattern}
      choose_letter
    end

    def choose_letter
      @letters.map {|letter| score letter}.max.letter
    end

    def score letter
      LetterScore.new letter, 10 * words_with(letter) + occurences_of(letter)
    end

    def words_with letter
      @words.select {|word| word.include? letter}.size
    end

    def occurences_of letter
      @words.join('').count letter
    end
  end
end
