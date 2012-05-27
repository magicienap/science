# coding: UTF-8

# Exception raised if arguments are invalid.
class InvalidArgumentsError < StandardError; end

module Science
  # Class used to manipulate vectors.
  class Vector
    attr_reader :norm, :orientation, :components

    # Instantiates a new Vector object.
    # @param [Hash] options Options to create the vector. :norm and :orientation or :x and :y.
    # @option options [Number] :norm The norm of the vector.
    # @option options [Number, Science::Angle] :orientation The orientation of the vector. If it is a number, it is assuming that it is in radians.
    # @option options [Number] :x The x component of the vector.
    # @option options [Number] :y The y component of the vector.
    # @return [Science::Vector] The new Vector object.
    def initialize(options)
      if options.has_keys? [:norm, :orientation]
        @norm = options[:norm]
        case options[:orientation]
          when Science::Angle then @orientation = options[:orientation]
          else @orientation = Science::Angle.new(options[:orientation], :radians)
        end
        calculate_components
      elsif options.has_keys? [:x, :y]
        @components = { x: options[:x], y: options[:y] }
        calculate_norm_and_orientation
      else
        raise InvalidArgumentsError, "Options should contain :norm and :orientation or :x and :y."
      end
    end
    
    # Returns the x component of the vector.
    # @return [Number] The x component of the vector.
    def x
      @components[:x]
    end
    
    # Returns the y component of the vector.
    # @return [Number] The y component of the vector.
    def y
      @components[:y]
    end
    
    # Adds the vector.
    # @param [Science::Vector] vector The vector to add.
    # @return [Science::Vector] A new vector with the vectors added.
    def +(vector)
      Science::Vector.new(x: x + vector.x, y: y + vector.y)
    end
    
    private
      
      # Calculates the components, given the norm and the orientation of the vector.
      def calculate_components
        x = @norm * Math.cos(@orientation.rad)
        y = @norm * Math.sin(@orientation.rad)
        @components = { x: x, y: y }
      end
      
      # Calculates the norm and the orientation, given the components of the vector.
      def calculate_norm_and_orientation
        x, y = @components.values
        @norm = Math.sqrt( x**2 + y**2 )
        @orientation = calculate_orientation
      end
      
      # Calculates the orientation of the vector.
      def calculate_orientation
        x, y = @components.values
        if x.pos? and y.zero?
          Science::Angle.new(0, :deg)
        elsif x.zero? and y.pos?
          Science::Angle.new(90, :deg)
        elsif x.neg? and y.zero?
          Science::Angle.new(180, :deg)
        elsif x.zero? and y.neg?
          Science::Angle.new(270, :deg)
        elsif x.pos? and y.pos?
          angle_in_rad = Science::Angle.new(Math.atan( y/x ), :rad)
          Science::Angle.new(angle_in_rad.deg, :deg)
        elsif x.neg? and y.pos?
          angle_in_rad = Science::Angle.new(Math.atan( y/x.abs ), :rad)
          Science::Angle.new(180 - angle_in_rad.deg, :deg)
        elsif x.neg? and y.neg?
          angle_in_rad = Science::Angle.new(Math.atan( y.abs/x.abs ), :rad)
          Science::Angle.new(180 + angle_in_rad.deg, :deg)
        elsif x.pos? and y.neg?
          angle_in_rad = Science::Angle.new(Math.atan( y.abs/x ), :rad)
          Science::Angle.new(360 - angle_in_rad.deg, :deg)
        end
      end
    
  end
end
