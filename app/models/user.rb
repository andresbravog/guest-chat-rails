require 'active_model/validations'

# Class holding the user validation and init logic
#
# Usage:
#
# user = User.new(username: 'andresbravog', dialect: :yoda)
class User
  include ActiveModel::Validations

  attr_accessor :username, :dialect

  validates :username, :dialect, presence: true
  validates :username, length: { in: 7..32 }
  validates :dialect, inclusion: { in: ALLOWED_DIALECTS }

  # Initialize user attributes with the given ones
  #
  # @param given_attributes [Hash] attributes to fill with
  #
  # Usage:
  #
  # user = User.new(username: 'andresbravog', dialect: :yoda)
  def initialize(given_attributes = {})
    @attributes = HashWithIndifferentAccess.new(given_attributes)
    @username = @attributes[:username]
    @dialect = @attributes[:dialect].try(:to_sym)
  end

  # Gives user attributes in hash format
  #
  # @return [Hash]
  def to_hash
    self.attributes
  end
end
