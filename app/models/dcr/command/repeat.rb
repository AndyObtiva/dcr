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

class Dcr
  class Command
    class Repeat < Command
      command_alias 'p'
      
      def call
        command_index_of_self = @program.expanded_commands.index(self)
        return if command_index_of_self.nil?
        commands_up_to_self = @program.expanded_commands[0...command_index_of_self]
        last_empty_command = commands_up_to_self.reverse.detect {|command| command.is_a?(Empty)}
        command_index_of_last_empty_command = @program.expanded_commands.index(last_empty_command).to_i # first index is 0 if no empty command is found
        commands_after_empty_command_up_to_self = @program.expanded_commands[command_index_of_last_empty_command...command_index_of_self]
        @program.expanded_commands[command_index_of_self..command_index_of_self] = commands_after_empty_command_up_to_self*value
      end
      
      def value
        super.to_i == 0 ? 1 : super.to_i
      end
    end
  end
end
