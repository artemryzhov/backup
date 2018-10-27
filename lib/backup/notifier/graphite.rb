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
        send_message(message.call(model, :status => status_data_for(status)))
      end

      def send_message(message)
        socket = TCPSocket.new(host, port)
        socket.write("backups.#{trigger} #{exit_status} #{Time.now.to_i.to_s}\n")
        socket.close
      end

    end
  end
end
