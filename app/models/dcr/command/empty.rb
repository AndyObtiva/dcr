class Dcr
  class Command
    # This command represents an empty line,
    # which separates repeatable groups of commands
    class Empty < Command
      command_alias ''
    end
  end
end
