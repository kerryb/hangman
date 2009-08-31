require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'kerryb/possibilities'

describe Kerryb::Possibilities do
  describe 'narrowing down using a pattern' do
    it "removes words which don't match" do
      possibilities = Kerryb::Possibilities.new %w(ant bee ape aardvark)
      possibilities.narrow_down 'a__'
      possibilities.words.should == %w(ant ape)
    end

    it "doesn't modify the caller's original word list" do
      words = %w(ant bee ape aardvark)
      possibilities = Kerryb::Possibilities.new words
      possibilities.narrow_down 'a__'
      words.should == %w(ant bee ape aardvark)
    end
  end

  describe 'suggesting a letter to guess' do
    it 'provides the letter which appears in the most words' do
      possibilities = Kerryb::Possibilities.new %w(ant bee ape)
      possibilities.suggest_guess.should == 'a'
    end
  end

  describe 'after marking a letter as used' do
    it "doesn't use the letter again" do
      possibilities = Kerryb::Possibilities.new %w(ant bee ape)
      possibilities.letter_used 'e'
      possibilities.suggest_guess.should == 'a'
    end
  end
end
