module Translate::Backend::Yoda
  API_URL = "http://www.yodaspeak.co.uk/webservice/yodatalk.php?wsdl"

  def self.translate(message)
    response = client.call(:yoda_talk, message: { message: message })
    response.body[:yoda_talk_response][:return]
  end

  private

  # Inits ruby soap client to interact with yoda API
  #
  # @return [Savon::Client]
  def self.client
    @client ||= Savon.client(wsdl: API_URL)
  end
end
