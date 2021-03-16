class Dcr
  class Polygon
    attr_accessor :point_array, :background
    
    def initialize(*point_array)
      point_array = point_array.first if point_array.size == 1 && point_array.first.is_a?(Array)
      @point_array = point_array
    end
  end
end
