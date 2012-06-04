# coding: UTF-8

# Mock Science::Angle
require 'spec_helper'

describe Science::Vector do
  before(:each) do
    @vector = Science::Vector.new({ norm: 15, orientation: Science::Angle.new(30, :degrees) }) # x: 12.99, y: 7.55
  
    @vectors_with_orientation_in_degrees = [
        { norm: 15, orientation: 0, x: 15, y: 0 },
        { norm: 15, orientation: 30, x: 12.99, y: 7.55 },
        { norm: 15, orientation: 90, x: 0, y: 15 },
        { norm: 15, orientation: 170, x: -14.77, y: 2.60 },
        { norm: 15, orientation: 180, x: -15, y: 0 },
        { norm: 15, orientation: 195, x: -14.49, y: -3.88 },
        { norm: 15, orientation: 270, x: 0, y: -15 },
        { norm: 15, orientation: 340, x: 14.10, y: -5.13 }
      ]
    @vectors_with_orientation_in_degrees.each do |vector|
      vector[:vector_norm_and_orientation] = Science::Vector.new(norm: vector[:norm], orientation: Science::Angle.new(vector[:orientation], :degrees))
      vector[:vector_components] = Science::Vector.new(x: vector[:x], y: vector[:y])
    end
    @vectors_with_orientation_in_radians = [
        { norm: 15, orientation: 0, x: 15, y: 0 },
        { norm: 15, orientation: Math::PI / 6, x: 12.99, y: 7.55 },
        { norm: 15, orientation: Math::PI / 2, x: 0, y: 15 },
        { norm: 15, orientation: 2.967, x: -14.77, y: 2.60 },
        { norm: 15, orientation: Math::PI, x: -15, y: 0 },
        { norm: 15, orientation: 3.403, x: -14.49, y: -3.88 },
        { norm: 15, orientation: 3 * Math::PI / 2, x: 0, y: -15 },
        { norm: 15, orientation: 5.934, x: 14.10, y: -5.13 }
      ]
    @vectors_with_orientation_in_radians.each do |vector|
      vector[:vector_norm_and_orientation] = Science::Vector.new(norm: vector[:norm], orientation: Science::Angle.new(vector[:orientation], :radians))
      vector[:vector_components] = Science::Vector.new(x: vector[:x], y: vector[:y])
    end
    @vectors = @vectors_with_orientation_in_degrees + @vectors_with_orientation_in_radians
  end

  describe "instantiation" do
    it "instantiates a new Vector given a norm and a orientation" do
      # The orientation can be : a Number (assuming rad - will be converted to an angle) or an Angle
      vector1 = Science::Vector.new(norm: 45, orientation: 5)
      vector1.norm.should be(45)
      vector1.orientation.rad.should be(5)
      
      vector2 = Science::Vector.new(norm: 45, orientation: Science::Angle.new(5, :radians))
      vector2.norm.should be(45)
      vector2.orientation.rad.should be(5)
      
      vector3 = Science::Vector.new(norm: 45, orientation: Science::Angle.new(45, :degrees))
      vector3.norm.should be(45)
      vector3.orientation.deg.should be(45)
    end
    
    it "calculates the components of the vector if the arguments are its norm and its orientation" do
      @vectors.each do |vector|
        vector[:vector_norm_and_orientation].x.should be_within(1).of(vector[:x])
        vector[:vector_norm_and_orientation].y.should be_within(1).of(vector[:y])
      end
    end
    
    it "instantiates a new Vector given components" do
      vector = Science::Vector.new(x: 5, y: -4.7)
      vector.x.should eq(5)
      vector.y.should eq(-4.7)
    end
    
    it "calculates the norm and the orientation of the vector if the arguments are its components" do
      @vectors_with_orientation_in_degrees.each do |vector|
        vector[:vector_components].norm.should be_within(1).of(vector[:norm])
        vector[:vector_components].orientation.deg.should be_within(1).of(vector[:orientation])
      end
      
      @vectors_with_orientation_in_radians.each do |vector|
        vector[:vector_components].norm.should be_within(1).of(vector[:norm])
        vector[:vector_components].orientation.rad.should be_within(1).of(vector[:orientation])
      end
    end
    
    it "raises an exception if the arguments are not : (1) the norm and the orientation or (2) the components" do
      expect { Science::Vector.new(norm: 45, x: 5) }.to raise_error(InvalidArgumentsError)
    end
  end
  
  describe "attributes" do
    it "gives access to the norm of the vector" do
      @vector.norm.should be(15)
    end
    
    it "gives access to the orientation of the vector" do
      @vector.orientation.deg.should be(30)
    end
    
    it "gives access to the components of the vector" do
      @vector.components[:x].should be_within(1).of(12.99)
      @vector.components[:y].should be_within(1).of(7.55)
      @vector.x.should be_within(1).of(12.99)
      @vector.y.should be_within(1).of(7.55)
    end
  end
  
  describe "math operations" do
    # To be completed with v3
    it "supports addition of two vectors" do
      v1 = Science::Vector.new(x: 10, y: 5)
      v2 = Science::Vector.new(x: -7, y: -3)
      v3 = Science::Vector.new(norm: 15, orientation: Science::Angle.new(30, :deg))

      (v1 + v2).x.should eq(3)
      (v1 + v2).y.should eq(2)
      (v1 + v2).norm.should be_within(1).of(3.61)
      (v1 + v2).orientation.deg.should be_within(1).of(33.69)
    end
    
    it "supports substraction of two vectors"
    it "supports multiplication of a vector and a scalar"
    it "supports multiplication of two vectors (scalar product or dot product)"
    it "supports unary plus"
    it "supports unary minus"
  end
  
  describe "linear combination" do
    it "calculates the linear combination of two vectors" do
      # First test...
      w = Science::Vector.new(x: 16, y: 26)
      u = Science::Vector.new(x: 2, y: 5)
      v = Science::Vector.new(x: 3, y: 4)
      
      result = w.linear_combination(u, v)
      result[:k1].should be(2)
      result[:k2].should be(4)
      
      # Second test...
      w = Science::Vector.new(x: 1, y: -1)
      u = Science::Vector.new(x: 19, y: 23)
      v = Science::Vector.new(x: -2, y: 0)
      
      result = w.linear_combination(u, v)
      result[:k1].should eq(-1/23)
      result[:k2].should eq(-21/23)
    end
  end
  
  describe "string representation" do
    it "represents a vector as a string" do
      vector = Science::Vector.new(x: 16, y: 26)
      vector.to_s.should eq("Vector :\n- x = 16\n- y = 26\n- norm = 30.528675044947494\n- orientation = 58.392497753751094°\n")
    end
  end
  
  # Comparison
  # Equality
  # to_a
  # to_s
  # to_f -> norm
  # colinear, ...
  # Extensions to Numeric -> a scalar times a vector
end

