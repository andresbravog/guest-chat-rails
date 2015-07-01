class RealtimeMessagesController < FayeRails::Controller
  channel '/messages' do
    monitor :subscribe do
      puts "Client #{client_id} subscribed to #{channel}. #{inspect}"
    end
    monitor :unsubscribe do
      puts "Client #{client_id} unsubscribed from #{channel}."
    end
    filter :in do
      puts "Inbound message #{message}."
      if message['data'].present?
        message['data']['message'] = Translate::Message.new(message['data']['message'], message['data']['dialect']).translate
        Rails.logger.debug "Translated on #{channel}: #{message}"
      end
      pass
    end
    subscribe do
      Rails.logger.debug "Received on #{channel}: #{message}"
    end
  end
end
