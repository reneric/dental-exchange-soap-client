require 'savon'
require 'X12'

# Constants
DEVELOPMENT = 'dev'
PRODUCTION = 'production'
LIVE_HOST = 'webservices'
DEV_HOST = 'prelive2'

# Date/time Variables
today = Time.now.strftime("%Y%m%d")
short_date = today[2..7]
time = Time.now.strftime('%H%M')

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
  'ns2:Client' => 'LocalMed',
  'ns2:ServiceID' => 'QU!Pql6jQ80:Y9q_GBe6x',
  'ns2:Username' => 'LocalMed',
  'ns2:Password' => 'Password1'
}

# SOAP Client Setup
client = Savon.client(
  wsdl: 'https://' + HOST + '.dentalxchange.com/dws/DwsService?wsdl',
  namespaces: namespaces,
  env_namespace: :S
)

# EDI X12 Request
x12 = <<-EOF
ISA*00*          *00*          *30*AA0989922      *30*330989922      *#{short_date}*#{time}*U*00401*000012145*0*P*:~
GS*HS*AA0989922*330989922*#{today}*#{time}*12145*X*004010X092~
ST*270*0001~
BHT*0022*13*ASX012145WEB*#{today}*#{time}~
HL*1**20*1~
NM1*PR*2*AETNA DENTAL PLANS*****PI*60054~
HL*2*1*21*1~
NM1*1P*1*OWENS*SEAN****XX*1205193117~
N3*GERMANY ROAD~
N4*GONAZALES*LA*70737~
PRV*PE*ZZ*1223G0001X~
HL*3*2*22*0~
TRN*1*12145*1AA0989922~
NM1*IL*1*GREEN*KATHY****MI*W213366058~
DMG*D8*19660906~
DTP*307*D8*#{today}~
EQ*30~
SE*16*0001~
GE*1*12145~
IEA*1*000012145~
EOF

# Send Request
response = client.call(:lookup_eligibility) do
  message(
    credentials: credentials,
    request: {
      'Content' => x12
    }
  )
end

puts Nokogiri::XML(response.to_s)
