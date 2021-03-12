class Dcr
  # Creates a class-based custom shape representing the `stick_figure` keyword by convention
  # When width=height, you get the standard aspect ratio
  # TODO support data-binding of x and y to move this shape around
  class StickFigure
    include Glimmer::UI::CustomShape
    
    options :x, :y, :width, :height
    
    before_body {
      @head_width = width*0.2
      @head_height = height*0.2
      @trunk_height = height*0.4
      @extremity_length = height*0.4
    }
    
    body {
      shape(x + @head_width/2.0 + @extremity_length, y) {
        oval(0, 0, @head_width, @head_height)
        line(@head_width/2.0, @head_height, @head_width/2.0, @head_height + @trunk_height)
        line(@head_width/2.0, @head_height + @trunk_height, @head_width/2.0 + @extremity_length, @head_height + @trunk_height + @extremity_length)
        line(@head_width/2.0, @head_height + @trunk_height, @head_width/2.0 - @extremity_length, @head_height + @trunk_height + @extremity_length)
        line(@head_width/2.0, @head_height*2, @head_width/2.0 + @extremity_length, @head_height + @trunk_height - @extremity_length)
        line(@head_width/2.0, @head_height*2, @head_width/2.0 - @extremity_length, @head_height + @trunk_height - @extremity_length)
      }
    }
  end
end
