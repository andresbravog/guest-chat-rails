class RealtimeUsersController < FayeRails::Controller
  channel '/users/**' do
    monitor :subscribe do
      puts "Client #{client_id} subscribed to #{channel}."
      username = channel.split('/').last
      unless OnlineUser.includes?(username)
        ::RealtimeUsersController.publish('/users', { username: username, action: 'add' })
      end
      OnlineUser.add(username)
    end
    monitor :unsubscribe do
      puts "Client #{client_id} unsubscribed from #{channel}."
      username = channel.split('/').last
      OnlineUser.remove(username)
      unless OnlineUser.includes?(username)
        ::RealtimeUsersController.publish('/users', { username: username, action: 'remove' })
      end
    end
  end

  channel '/users' do
    subscribe do
      Rails.logger.debug "Received on #{channel}: #{inspect}"
    end
  end
end
