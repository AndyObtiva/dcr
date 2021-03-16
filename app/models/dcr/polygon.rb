require 'equalizer'
  
class Dcr
  class Polygon
    ATTRIBUTES = [:point_array, :background]
    
    include Equalizer.new(*ATTRIBUTES)
    
    attr_accessor *ATTRIBUTES
    
    def initialize(*point_array)
      point_array = point_array.first if point_array.size == 1 && point_array.first.is_a?(Array)
      @point_array = point_array
    end
  end
end
