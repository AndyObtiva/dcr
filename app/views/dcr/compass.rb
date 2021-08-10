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
          line(0, 0, 18, 0)
          line(14, -4, 18, 0)
          line(14, 4, 18, 0)
        }
      }
      
      def apply_transform
        pd angle, location_x, location_y
        body_root.content {
          transform {
            rotate(angle - 90)
            translate location_x, location_y
          }
        }
      end
  
    end
  end
end
