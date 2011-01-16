require "fsr/app"
module FSR
  module Cmd
    class Luarun < Command
      attr_reader :script, :arguments #arguments is just a string

      def initialize(fs_socket = nil)
        @fs_socket = fs_socket # FSR::CommandSocket obj
      end

      # Send the command to the event socket, using api by default.
      def run(api_method = :api)
        orig_command = "%s %s" % [api_method, raw]
        Log.debug "saying #{orig_command}"
        @fs_socket.say(orig_command)
      end
    
      # This method builds the API command to send to the freeswitch event socket
      def raw
        orig_command = "luarun #{@script}"
        orig_command += " #{@arguments}" unless @arguments.nil?
      end
    end

  register(:luarun, Luarun)
  end
end
