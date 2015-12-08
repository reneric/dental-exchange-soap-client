require 'savon'
require_relative 'edi_document.rb'

# Load Credentials
credentials = YAML::load_file(File.join(__dir__, 'config/credentials.yml'))

# Constants
DEVELOPMENT = 'dev'
PRODUCTION = 'production'
DEV_HOST = 'prelive2'
PRODUCTION_HOST = 'webservices'

# Set Environment
ENVIRONMENT = 'dev'

# Set host based on environment
HOST =
  if ENVIRONMENT == PRODUCTION
    PRODUCTION_HOST
  else
    DEV_HOST
  end

# Set XML Request Namespaces
namespaces = {
  'xmlns:S' => 'http://schemas.xmlsoap.org/soap/envelope/',
  'xmlns:ns2' => 'dxci.common',
  'xmlns:ns3' => 'dxci.dws'
}

# Testing Credentials
credentials = {
  'ns2:Client' => credentials['CLIENT'],
  'ns2:ServiceID' => credentials['SERVICE_ID'],
  'ns2:Username' => credentials['USERNAME'],
  'ns2:Password' => credentials['PASSWORD']
}

# SOAP Client Setup
client = Savon.client(
  wsdl: 'https://' + HOST + '.dentalxchange.com/dws/DwsService?wsdl',
  namespaces: namespaces,
  env_namespace: :S
)

# Send Request
response = client.call(:lookup_eligibility) do
  message(
    credentials: credentials,
    request: {
      'Content' => EDI_DOCUMENT
    }
  )
end

puts Nokogiri::XML(response.to_s)
