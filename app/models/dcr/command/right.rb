class Dcr
  class Command
    class Right < Command
      def call
        @program.angle += value
      end
      
      def value
        @value.to_f == 0 ? 90 : @value.to_f
      end
    end
  end
end
