class Dcr
  module View
    class Compass
      include Glimmer::UI::CustomShape
  
      option :location_x, default: 0
      option :location_y, default: 0
      option :angle, default: 0
      
      def location_x=(value)
        options[:location_x] = value
        apply_transform
      end
      
      def location_y=(value)
        options[:location_y] = value
        apply_transform
      end
      
      def angle=(value)
        options[:angle] = value
        apply_transform
      end
      
      body {
        shape(0, 0) {
          # using polygons because transforms are not working properly at 45 degrees when used with unfilled shapes like lines
          polygon(0, 0, 18, 0, 18, 1, 1, 1) {
            background :black
          }
          polygon(14, -4, 14, 5, 18, 1, 18, 0) {
            background :black
          }
          
          current_transform
        }
      }
      
      def apply_transform
        body_root.content {
          current_transform
        }
      end
      
      def current_transform
        transform {
          translate location_x, location_y
          rotate(angle - 90)
        }
      end
  
    end
    
  end
  
end
