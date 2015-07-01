class Translate::Message
  attr_accessor :message, :dialect

  def initialize(message, dialect)
    @message = message
    @dialect = dialect
  end

  def translate
    backend.translate(message)
  end

  private

  def backend
    klass_name = "Translate::Backend::#{dialect.to_s.camelcase}"
    klass_name.constantize rescue nil
  end
end
