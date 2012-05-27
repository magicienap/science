# coding: UTF-8

# Exception raised if arguments are invalid.
class InvalidArgumentsError < StandardError; end

module Science
  # Class used to convert angles 
  class Angle
    attr_reader :radians, :degrees
    alias :rad :radians
    alias :deg :degrees

    # Instantiates a new Angle object.
    # @param [Number] angle The value of the angle.
    # @param [Symbol] unit A symbol representing the unit of the angle (:degrees or :deg; :radians or :rad)
    # @return [Science::Angle] The new Angle object.
    def initialize(angle, unit)
      case unit
        when :degrees, :deg then convert_and_normalize_degrees(angle)
        when :radians, :rad then convert_and_normalize_radians(angle)
        else
          raise InvalidArgumentsError, "Unit should be :degrees, :deg, :radians ord :rad."
      end
    end
    
    # Returns the value of the angle (default unit: radians).
    # @param [Symbol] unit A symbol representing the unit of the angle (:degrees or :deg; :radians or :rad)
    # @return [Number] The value of the angle in the specified unit.
    def to_f(unit = :radians)
      case unit
        when :degrees, :deg then @degrees
        when :radians, :rad then @radians
        else
          raise InvalidArgumentsError, "Unit should be :degrees, :deg, :radians ord :rad."
      end
    end
    
    # Returns the string representation of the angle (default unit: radians).
    # @param [Symbol] unit A symbol representing the unit of the angle (:degrees or :deg; :radians or :rad)
    # @return [String] The string representation of the angle.
    def to_s(unit = :radians)
      case unit
        when :degrees, :deg then "#{@degrees}°"
        when :radians, :rad then "#@radians rad"
        else
          raise InvalidArgumentsError, "Unit should be :degrees, :deg, :radians ord :rad."
      end
    end
    
    private
    
      # Normalize the angle. The angle should be positive and less than the angle in a circle.
      # @param [Number] angle The angle to normalize.
      # @param [Number] angle_in_a_circle The number representing the angle in a circle (for example, 360° for degrees).
      # @return [Number] The normalized angle.
      def normalize_angle(angle, angle_in_a_circle)
        while angle <= 0
          angle += angle_in_a_circle
        end
      
        while angle >= angle_in_a_circle
          angle -= angle_in_a_circle
        end
        
        angle
      end
    
      # Normalize the angle (in degrees) and converts it in radians.
      # @param [Number] angle The angle in degrees to be normalized and converted.
      def convert_and_normalize_degrees(angle)
        @degrees = normalize_angle(angle, 360)
        @radians = deg_to_rad(@degrees)
      end
      
      # Normalize the angle (in radians) and converts it in degrees.
      # @param [Number] angle The angle in radians to be normalized and converted.
      def convert_and_normalize_radians(angle)
        @radians = normalize_angle(angle, (2 * Math::PI))
        @degrees = rad_to_deg(@radians)
      end
      
      # Convert an angle in degrees into radians
      # @param [Number] deg The angle in degrees.
      # @return [Number] The angle in radians.
      def deg_to_rad(deg)
        return (2 * Math::PI) * deg / 360
      end
      
      # Convert an angle in radians into degrees.
      # @param [Number] rad The angle in radians.
      # @return [Number] The angle in degrees.
      def rad_to_deg(rad)
        return 360 * rad / (2 * Math::PI)
      end
  end
end

# Notes
# - Add Numeric#rad and Numeric#deg -> return an Angle object
# - Support all Numeric operations
# - Support Math operations (trigonometic : cos, sin, tan...)
