# coding: UTF-8

require 'spec_helper'

describe Numeric do
  before :each do
    @positive_numbers = [5, 10.5]
    @negative_numbers = [-5, -10.5]
  end
  
  describe "#positive?" do
    it "returns true if the number is positive" do
      @positive_numbers.each do |number|
        number.positive?.should be_true
        number.pos?.should be_true
      end
    end
    
    it "returns false if the number is negative" do
      @negative_numbers.each do |number|
        number.positive?.should be_false
        number.pos?.should be_false
      end
    end
    
    it "returns true if the number is 0" do
      0.positive?.should be_true
      0.pos?.should be_true
    end
  end
  
  describe "#negative?" do
    it "returns true if the number is negative" do
      @negative_numbers.each do |number|
        number.negative?.should be_true
        number.neg?.should be_true
      end
    end
    
    it "returns false if the number is positive" do
      @positive_numbers.each do |number|
        number.negative?.should be_false
        number.neg?.should be_false
      end
    end
    
    it "returns true if the number is 0" do
      0.negative?.should be_true
      0.neg?.should be_true
    end
  end
end
