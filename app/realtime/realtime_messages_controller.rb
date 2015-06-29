class RealtimeMessagesController < FayeRails::Controller
  channel '/messages' do
    subscribe do
      Rails.logger.debug "Received on #{channel}: #{inspect}"
    end
  end
end
