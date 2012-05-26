# coding: UTF-8

require 'spec_helper'

describe Hash do
  before :each do
    @hash = { key1: "Hello", key2: "Test", "key" => "It works!" }
  end
  
  describe "#has_keys?" do
    it "returns true if all the keys provided are in the hash" do
      @hash.has_keys?([:key1, :key2]).should be_true
    end
    
    it "returns false if at least one of the keys provided is not in the hash" do
      @hash.has_keys?([:key1, :key2, :key3]).should be_false
    end
  end
end
