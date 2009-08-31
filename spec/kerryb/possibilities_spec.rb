require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'kerryb/possibilities'

describe Kerryb::Possibilities do
  it 'provides the most common letter for the current word list' do
    possibilities = Kerryb::Possibilities.new %w(ant bee aardvark)
    possibilities.most_common_letter.should == 'a'
  end
end
