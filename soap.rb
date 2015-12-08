require 'savon'
require_relative 'edi_document.rb'
require_relative 'credentials.rb'

# Constants
DEVELOPMENT = 'dev'
PRODUCTION = 'production'
LIVE_HOST = 'webservices'
DEV_HOST = 'prelive2'

# Set Environment
ENVIRONMENT = 'dev'

# Set host based on environment
HOST =
  if ENVIRONMENT == PRODUCTION
    LIVE_HOST
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
  'ns2:Client' => CLIENT,
  'ns2:ServiceID' => SERVICE_ID,
  'ns2:Username' => USERNAME,
  'ns2:Password' => PASSWORD
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
