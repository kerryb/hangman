require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'kerryb/kerryb'

describe Kerryb::Kerryb do

  it "should be instantiable with no paramters" do

    lambda { Kerryb::Kerryb.new }.should_not raise_error

  end

end