class Dcr
  class Command
    class Right < Command
      command_alias 'r'
    
      def call
        @program.angle += value
      end
      
      def value
        super.to_f == 0 ? 90 : super.to_f
      end
    end
  end
end
