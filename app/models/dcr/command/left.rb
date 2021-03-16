class Dcr
  class Command
    class Left < Command
      command_alias 'l'
      command_exclusion 'f'
      
      def call
        @program.angle -= value
      end
      
      def value
        @value.to_f == 0 ? 90 : @value.to_f
      end
    end
  end
end
