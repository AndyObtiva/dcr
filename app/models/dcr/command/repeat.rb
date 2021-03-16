class Dcr
  class Command
    class Repeat < Command
      def call
        command_index_of_self = @program.expanded_commands.index(self)
        commands_up_to_self = @program.expanded_commands[0...command_index_of_self]
        last_empty_command = commands_up_to_self.reverse.detect {|command| command.is_a?(Empty)}
        command_index_of_last_empty_command = @program.expanded_commands.index(last_empty_command).to_i # first index is 0 if no empty command is found
        commands_after_empty_command_up_to_self = @program.expanded_commands[command_index_of_last_empty_command...command_index_of_self]
        @program.expanded_commands[command_index_of_self..command_index_of_self] = commands_after_empty_command_up_to_self*value
      end
      
      def value
        @value.to_i == 0 ? 1 : @value.to_i
      end
    end
  end
end
