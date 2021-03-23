# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
require_relative '../polygon'

class Dcr
  class Command
    class Forward < Command
      command_alias 'f'
    
      def call
        p1 = java.awt.geom.Point2D::Double.new(value, 0)
        p2 = java.awt.geom.Point2D::Double.new(0, 0)
        t = java.awt.geom.AffineTransform.new
        t.set_to_rotation(@program.angle*(Math::PI/2.0)/90.0 - Math::PI/2.0)
        t.transform(p1, p2)
        new_x = @program.location_x + p2.x
        new_y = @program.location_y + p2.y
        @program.polygons.last.point_array += [new_x, new_y]
        @program.set_location(new_x, new_y)
      end
      
      def value
        super.to_f == 0 ? 1 : super.to_f
      end
    end
  end
end
