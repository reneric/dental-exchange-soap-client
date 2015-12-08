Dental Exchange SOAP Client
======================

SOAP Client for connecting to the Dentalxchange API

## Getting Started

1. Set the correct environment in `request.rb`:
	``` ruby
	ENVIRONMENT = 'dev' # or 'production'
	```

2. Add your EDI (x12) document to `edi_document.rb`.

	``` ruby
	EDI_DOCUMENT = <<-EOF
	ISA*00*          *00*          *30*AA0989922      *30*330989922      *(DATE-YYYYMMDD)*(TIME-HHMM)*U*00401*000012145*0*P*:~
	GS*HS*AA0989922*330989922*(DATE-YYMMDD)*(TIME-HHMM)*12145*X*004010X092~
	ST*270*0001~
	BHT*0022*13*ASX012145WEB*(DATE-YYMMDD)*(TIME-HHMM)~
	HL*1**20*1~
	NM1*PR*2*(PLAN NAME)*****PI*(PAYERIDCODE)~
	HL*2*1*21*1~
	NM1*1P*1*(PLAST)*(PFIRST)****XX*(PNPI)~
	N3*(STREET ADDRESS)~
	N4*(CITY)*(STATE)*(ZIP)~
	PRV*PE*ZZ*1223G0001X~
	HL*3*2*22*0~
	TRN*1*12145*1AA0989922~
	NM1*IL*1*(SLAST)*(SFIRST)****MI*(MEMBERID)~
	DMG*D8*(SDOB)~
	DTP*307*D8*(DATE-YYMMDD)~
	EQ*30~
	SE*16*0001~
	GE*1*12145~
	IEA*1*000012145~
	EOF
	```

3. Add your credentials to `config/credentials.yml`.

	``` yaml
	CLIENT: 'ClientName'
	SERVICE_ID: 'QU!Pql6asdfsdajQ80:Yas96x'
	USERNAME: 'MyUsername'
	PASSWORD: 'MyPassword123'
	```

4. Send the SOAP request:

	``` bash
	$ ruby request.rb
	```


### Available Operations:
	lookup_eligibility
	lookup_terminal_eligibility
	lookup_family_eligibility
	lookup_claim_status
	lookup_terminal_claim_status
	update_terminal
	submit_claim
	validate_claim
	get_payer_list
	get_claim_status
	get_eligibility

