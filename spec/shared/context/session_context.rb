RSpec.shared_context 'session' do

  # Creates session for the given user
  #
  # @param user [User] user to be logged in as
  def session_for(user)
    user.to_hash
  end
end
