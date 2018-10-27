module Backup
  module Notifier
    class Graphite < Base
      attr_accessor :host
      attr_accessor :port

      def initialize(model, &block)
        super
        instance_eval(&block) if block_given?
      end

      private

      def notify!(status)
        send_message()
      end

      def send_message()
        socket = TCPSocket.new(host, port)
        socket.write("backups.#{model.trigger} #{model.exit_status} #{Time.now.to_i.to_s}\n")
        socket.close
      end

    end
  end
end
