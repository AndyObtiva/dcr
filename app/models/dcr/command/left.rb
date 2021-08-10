class Dcr
  class Command
    class Left < Command
      command_alias 'l'
      command_exclusion 'f'
      
      def call
        @program.angle -= value
      end
      
      def value
        super.to_f == 0 ? 90.0 : super.to_f
      end
    end
  end
end
