require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'kerryb/possibilities'

describe Kerryb::Possibilities do
  describe 'narrowing down using a pattern' do
  end

  describe 'suggesting a letter to guess' do
    it 'provides the letter which appears in the most words' do
      possibilities = Kerryb::Possibilities.new %w(ant bee ape man)
      possibilities.suggest_guess('___').should == 'a'
    end

    describe 'when two letters appear in the same number of words' do
      it 'provides the one that appears the most times' do
        possibilities = Kerryb::Possibilities.new %w(ant bee ape)
        possibilities.suggest_guess('___').should == 'e'
      end
    end

    it "ignores potential words which don't match" do
      possibilities = Kerryb::Possibilities.new %w(ant bee ape man)
      possibilities.suggest_guess('b__').should == 'e'
    end

    it "ignores already-used letters" do
      possibilities = Kerryb::Possibilities.new %w(ant bee ape man)
      possibilities.letter_used 'a'
      possibilities.suggest_guess('___').should == 'e'
    end
  end
end
