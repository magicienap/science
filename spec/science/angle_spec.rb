# coding: UTF-8

require 'spec_helper'

describe Science::Angle do
  describe "#new" do
    it "instantiates a new Angle object given a angle in radians" do
      Science::Angle.new(1, :radians).radians.should be(1)
      Science::Angle.new(1, :radians).rad.should be(1)
      Science::Angle.new(1, :rad).radians.should be(1)
      Science::Angle.new(1, :rad).rad.should be(1)
    end
    
    it "converts the angle (given in radians) if it is greater than 2pi" do
      Science::Angle.new(2 * Math::PI, :radians).radians.should be_within(0.0001).of(0)
      Science::Angle.new(3 * Math::PI, :radians).radians.should be_within(0.0001).of(Math::PI)
    end
    
    it "converts the angle (given in radians) if it is lesser than 2pi" do
      Science::Angle.new(-2 * Math::PI, :radians).radians.should be_within(0.0001).of(0)
      Science::Angle.new(-3 * Math::PI, :radians).radians.should be_within(0.0001).of(Math::PI)
    end
    
    it "converts the angle (given in radians) in degrees" do
      Science::Angle.new(2 * Math::PI, :radians).degrees.should be_within(0.0001).of(0)
      Science::Angle.new(3 * Math::PI, :radians).degrees.should be_within(0.0001).of(180)
    end
    
    it "instantiates a new Angle object given a angle in degrees and convert it if it is greater than 360" do
      Science::Angle.new(45, :degrees).degrees.should be(45)
      Science::Angle.new(45, :degrees).deg.should be(45)
      Science::Angle.new(45, :deg).degrees.should be(45)
      Science::Angle.new(45, :deg).deg.should be(45)
    end
    
    it "converts the angle (given in degrees) if it is greater than 360" do
      Science::Angle.new(370, :degrees).degrees.should be_within(0.0001).of(10)
      Science::Angle.new(750, :degrees).degrees.should be_within(0.0001).of(30)
    end
    
    it "converts the angle (given in degrees) if it is lesser than 360" do
      Science::Angle.new(-370, :degrees).degrees.should be_within(0.0001).of(350)
      Science::Angle.new(-750, :degrees).degrees.should be_within(0.0001).of(330)
    end
    
    it "converts the angle (given in degrees) in radians" do
      Science::Angle.new(370, :degrees).radians.should be_within(0.0001).of(0.1745)
      Science::Angle.new(750, :degrees).radians.should be_within(0.0001).of(0.5235)
    end
    
    it "raises an exception if the paramater is not an angle in degrees or in radians" do
      expect { Science::Angle.new(45, :angle) }.to raise_error(InvalidArgumentsError)
    end
  end
  
  describe "conversion" do
    before(:each) do
      @degrees = Science::Angle.new(-370, :degrees)
      @radians = Science::Angle.new(-3 * Math::PI, :radians)
    end
  
    describe "#to_f" do
      it "returns the angle in radians as a float" do
        @degrees.to_f.should be_within(0.0001).of(6.1087)
        @radians.to_f.should be_within(0.0001).of(Math::PI)
      end
      
      it "returns the angle with the specified unit passed as argument as a float" do
        @degrees.to_f(:rad).should be_within(0.0001).of(6.1087)
        @radians.to_f(:deg).should be_within(0.0001).of(180)
      end
      
      it "raises an exception if the unit is not degrees or radians" do
        expect { @degrees.to_f(:angle) }.to raise_error(InvalidArgumentsError)
        expect { @radians.to_f(:angle) }.to raise_error(InvalidArgumentsError)
      end
    end
    
    describe "#to_s" do
      it "returns the angle in radians (with the unit) as a string if no arguments are giving" do
        @degrees.to_s.should eq("6.108652381980153 rad")
        @radians.to_s.should eq("#{Math::PI} rad")
      end
      
      it "returns the angle with the specified unit passed as argument as a string" do
        @degrees.to_s(:rad).should eq("6.108652381980153 rad")
        @radians.to_s(:deg).should eq("180.0°")
        puts @radians.degrees
      end
      
      it "raises an exception if the unit is not degrees or radians" do
        expect { @degrees.to_s(:angle) }.to raise_error(InvalidArgumentsError)
        expect { @radians.to_s(:angle) }.to raise_error(InvalidArgumentsError)
      end
    end
  end
end
