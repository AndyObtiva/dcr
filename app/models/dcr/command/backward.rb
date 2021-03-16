class Dcr
  class Command
    class Backward < Command
      command_alias 'b'
    
      def call
        p1 = java.awt.geom.Point2D::Double.new(value, 0)
        p2 = java.awt.geom.Point2D::Double.new(0, 0)
        t = java.awt.geom.AffineTransform.new
        t.set_to_rotation(@program.angle*(Math::PI/2.0)/90.0 - Math::PI/2.0)
        t.transform(p1, p2)
        new_x = @program.location_x - p2.x
        new_y = @program.location_y - p2.y
        @program.polygons.last.point_array += [new_x, new_y]
        @program.notify_observers(:polygons) # TODO do away with this using nested data-binding
        @program.location_x = new_x
        @program.location_y = new_y
      end
      
      def value
        @value.to_f == 0 ? 1 : @value.to_f
      end
    end
  end
end
