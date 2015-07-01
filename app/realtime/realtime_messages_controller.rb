class RealtimeMessagesController < FayeRails::Controller
  channel '/messages' do
    monitor :subscribe do
      puts "Client #{client_id} subscribed to #{channel}. #{inspect}"
    end
    monitor :unsubscribe do
      puts "Client #{client_id} unsubscribed from #{channel}."
    end
    subscribe do
      Rails.logger.debug "Received on #{channel}: #{inspect}"
    end
  end
end
