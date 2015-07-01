module OnlineUser
  @@online_users = {}

  # Add a user to the online ones
  # sum one to the open connexions for this user if he is arleady online
  #
  # @param username [String] username to be added
  def self.add(username)
    @@online_users[username.to_s] ||= 0
    @@online_users[username.to_s] += 1
  end

  # Remove a user from the online ones if is the last open connexion for this user
  #
  # @param username [String] username to be removed
  def self.remove(username)
    return if (@@online_users[username.to_s] || 0) < 1
    @@online_users[username.to_s] -= 1
  end

  # Returns all online users
  #
  # @return [Array(User)]
  def self.all
    @@online_users.reject { |_, v| v < 1 }.map { |k, _| User.new(username: k) }
  end

  # Whenever the user is already online or not
  #
  # @param username [String] username to be checked
  def self.includes?(username)
    (@@online_users[username.to_s] || 0) > 0
  end
end
