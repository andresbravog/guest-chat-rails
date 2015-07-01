module Translate::Backend::Pirate
  API_URL = 'http://isithackday.com/arrpi.php'

  def self.translate(message)
    response = RestClient.get API_URL, params: { text: message, format: 'json' }
    body = JSON.parse(response.body)
    body['translation']['pirate']
  end
end
