# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Country.count == 0
  puts "Creating Countries..."
  countries = [ {:id=>1,:iso=>"AD",:name=>"Andorra"},
                {:id=>2,:iso=>"AE",:name=>"United Arab Emirates"},
                {:id=>3,:iso=>"AF",:name=>"Afghanistan"},
                {:id=>4,:iso=>"AG",:name=>"Antigua and Barbuda"},
                {:id=>5,:iso=>"AI",:name=>"Anguilla"},
                {:id=>6,:iso=>"AL",:name=>"Albania"},
                {:id=>7,:iso=>"AM",:name=>"Armenia"},
                {:id=>8,:iso=>"AO",:name=>"Angola"},
                {:id=>9,:iso=>"AQ",:name=>"Antarctica"},
                {:id=>10,:iso=>"AR",:name=>"Argentina"},
                {:id=>11,:iso=>"AS",:name=>"American Samoa"},
                {:id=>12,:iso=>"AT",:name=>"Austria"},
                {:id=>13,:iso=>"AU",:name=>"Australia"},
                {:id=>14,:iso=>"AW",:name=>"Aruba"},
                {:id=>15,:iso=>"AX",:name=>"Aland Islands"},
                {:id=>16,:iso=>"AZ",:name=>"Azerbaijan"},
                {:id=>17,:iso=>"BA",:name=>"Bosnia and Herzegovina"},
                {:id=>18,:iso=>"BB",:name=>"Barbados"},
                {:id=>19,:iso=>"BD",:name=>"Bangladesh"},
                {:id=>20,:iso=>"BE",:name=>"Belgium"},
                {:id=>21,:iso=>"BF",:name=>"Burkina Faso"},
                {:id=>22,:iso=>"BG",:name=>"Bulgaria"},
                {:id=>23,:iso=>"BH",:name=>"Bahrain"},
                {:id=>24,:iso=>"BI",:name=>"Burundi"},
                {:id=>25,:iso=>"BJ",:name=>"Benin"},
                {:id=>26,:iso=>"BL",:name=>"Saint Barthelemy"},
                {:id=>27,:iso=>"BM",:name=>"Bermuda"},
                {:id=>28,:iso=>"BN",:name=>"Brunei"},
                {:id=>29,:iso=>"BO",:name=>"Bolivia"},
                {:id=>30,:iso=>"BQ",:name=>"Bonaire, Saint Eustatius and Saba "},
                {:id=>31,:iso=>"BR",:name=>"Brazil"},
                {:id=>32,:iso=>"BS",:name=>"Bahamas"},
                {:id=>33,:iso=>"BT",:name=>"Bhutan"},
                {:id=>34,:iso=>"BV",:name=>"Bouvet Island"},
                {:id=>35,:iso=>"BW",:name=>"Botswana"},
                {:id=>36,:iso=>"BY",:name=>"Belarus"},
                {:id=>37,:iso=>"BZ",:name=>"Belize"},
                {:id=>38,:iso=>"CA",:name=>"Canada"},
                {:id=>39,:iso=>"CC",:name=>"Cocos Islands"},
                {:id=>40,:iso=>"CD",:name=>"Democratic Republic of the Congo"},
                {:id=>41,:iso=>"CF",:name=>"Central African Republic"},
                {:id=>42,:iso=>"CG",:name=>"Republic of the Congo"},
                {:id=>43,:iso=>"CH",:name=>"Switzerland"},
                {:id=>44,:iso=>"CI",:name=>"Ivory Coast"},
                {:id=>45,:iso=>"CK",:name=>"Cook Islands"},
                {:id=>46,:iso=>"CL",:name=>"Chile"},
                {:id=>47,:iso=>"CM",:name=>"Cameroon"},
                {:id=>48,:iso=>"CN",:name=>"China"},
                {:id=>49,:iso=>"CO",:name=>"Colombia"},
                {:id=>50,:iso=>"CR",:name=>"Costa Rica"},
                {:id=>51,:iso=>"CU",:name=>"Cuba"},
                {:id=>52,:iso=>"CV",:name=>"Cape Verde"},
                {:id=>53,:iso=>"CW",:name=>"Curacao"},
                {:id=>54,:iso=>"CX",:name=>"Christmas Island"},
                {:id=>55,:iso=>"CY",:name=>"Cyprus"},
                {:id=>56,:iso=>"CZ",:name=>"Czech Republic"},
                {:id=>57,:iso=>"DE",:name=>"Germany"},
                {:id=>58,:iso=>"DJ",:name=>"Djibouti"},
                {:id=>59,:iso=>"DK",:name=>"Denmark"},
                {:id=>60,:iso=>"DM",:name=>"Dominica"},
                {:id=>61,:iso=>"DO",:name=>"Dominican Republic"},
                {:id=>62,:iso=>"DZ",:name=>"Algeria"},
                {:id=>63,:iso=>"EC",:name=>"Ecuador"},
                {:id=>64,:iso=>"EE",:name=>"Estonia"},
                {:id=>65,:iso=>"EG",:name=>"Egypt"},
                {:id=>66,:iso=>"EH",:name=>"Western Sahara"},
                {:id=>67,:iso=>"ER",:name=>"Eritrea"},
                {:id=>68,:iso=>"ES",:name=>"Spain"},
                {:id=>69,:iso=>"ET",:name=>"Ethiopia"},
                {:id=>70,:iso=>"FI",:name=>"Finland"},
                {:id=>71,:iso=>"FJ",:name=>"Fiji"},
                {:id=>72,:iso=>"FK",:name=>"Falkland Islands"},
                {:id=>73,:iso=>"FM",:name=>"Micronesia"},
                {:id=>74,:iso=>"FO",:name=>"Faroe Islands"},
                {:id=>75,:iso=>"FR",:name=>"France"},
                {:id=>76,:iso=>"GA",:name=>"Gabon"},
                {:id=>77,:iso=>"GB",:name=>"United Kingdom"},
                {:id=>78,:iso=>"GD",:name=>"Grenada"},
                {:id=>79,:iso=>"GE",:name=>"Georgia"},
                {:id=>80,:iso=>"GF",:name=>"French Guiana"},
                {:id=>81,:iso=>"GG",:name=>"Guernsey"},
                {:id=>82,:iso=>"GH",:name=>"Ghana"},
                {:id=>83,:iso=>"GI",:name=>"Gibraltar"},
                {:id=>84,:iso=>"GL",:name=>"Greenland"},
                {:id=>85,:iso=>"GM",:name=>"Gambia"},
                {:id=>86,:iso=>"GN",:name=>"Guinea"},
                {:id=>87,:iso=>"GP",:name=>"Guadeloupe"},
                {:id=>88,:iso=>"GQ",:name=>"Equatorial Guinea"},
                {:id=>89,:iso=>"GR",:name=>"Greece"},
                {:id=>90,:iso=>"GS",:name=>"South Georgia and the South Sandwich Islands"},
                {:id=>91,:iso=>"GT",:name=>"Guatemala"},
                {:id=>92,:iso=>"GU",:name=>"Guam"},
                {:id=>93,:iso=>"GW",:name=>"Guinea-Bissau"},
                {:id=>94,:iso=>"GY",:name=>"Guyana"},
                {:id=>95,:iso=>"HK",:name=>"Hong Kong"},
                {:id=>96,:iso=>"HM",:name=>"Heard Island and McDonald Islands"},
                {:id=>97,:iso=>"HN",:name=>"Honduras"},
                {:id=>98,:iso=>"HR",:name=>"Croatia"},
                {:id=>99,:iso=>"HT",:name=>"Haiti"},
                {:id=>100,:iso=>"HU",:name=>"Hungary"},
                {:id=>101,:iso=>"ID",:name=>"Indonesia"},
                {:id=>102,:iso=>"IE",:name=>"Ireland"},
                {:id=>103,:iso=>"IL",:name=>"Israel"},
                {:id=>104,:iso=>"IM",:name=>"Isle of Man"},
                {:id=>105,:iso=>"IN",:name=>"India"},
                {:id=>106,:iso=>"IO",:name=>"British Indian Ocean Territory"},
                {:id=>107,:iso=>"IQ",:name=>"Iraq"},
                {:id=>108,:iso=>"IR",:name=>"Iran"},
                {:id=>109,:iso=>"IS",:name=>"Iceland"},
                {:id=>110,:iso=>"IT",:name=>"Italy"},
                {:id=>111,:iso=>"JE",:name=>"Jersey"},
                {:id=>112,:iso=>"JM",:name=>"Jamaica"},
                {:id=>113,:iso=>"JO",:name=>"Jordan"},
                {:id=>114,:iso=>"JP",:name=>"Japan"},
                {:id=>115,:iso=>"KE",:name=>"Kenya"},
                {:id=>116,:iso=>"KG",:name=>"Kyrgyzstan"},
                {:id=>117,:iso=>"KH",:name=>"Cambodia"},
                {:id=>118,:iso=>"KI",:name=>"Kiribati"},
                {:id=>119,:iso=>"KM",:name=>"Comoros"},
                {:id=>120,:iso=>"KN",:name=>"Saint Kitts and Nevis"},
                {:id=>121,:iso=>"KP",:name=>"North Korea"},
                {:id=>122,:iso=>"KR",:name=>"South Korea"},
                {:id=>123,:iso=>"XK",:name=>"Kosovo"},
                {:id=>124,:iso=>"KW",:name=>"Kuwait"},
                {:id=>125,:iso=>"KY",:name=>"Cayman Islands"},
                {:id=>126,:iso=>"KZ",:name=>"Kazakhstan"},
                {:id=>127,:iso=>"LA",:name=>"Laos"},
                {:id=>128,:iso=>"LB",:name=>"Lebanon"},
                {:id=>129,:iso=>"LC",:name=>"Saint Lucia"},
                {:id=>130,:iso=>"LI",:name=>"Liechtenstein"},
                {:id=>131,:iso=>"LK",:name=>"Sri Lanka"},
                {:id=>132,:iso=>"LR",:name=>"Liberia"},
                {:id=>133,:iso=>"LS",:name=>"Lesotho"},
                {:id=>134,:iso=>"LT",:name=>"Lithuania"},
                {:id=>135,:iso=>"LU",:name=>"Luxembourg"},
                {:id=>136,:iso=>"LV",:name=>"Latvia"},
                {:id=>137,:iso=>"LY",:name=>"Libya"},
                {:id=>138,:iso=>"MA",:name=>"Morocco"},
                {:id=>139,:iso=>"MC",:name=>"Monaco"},
                {:id=>140,:iso=>"MD",:name=>"Moldova"},
                {:id=>141,:iso=>"ME",:name=>"Montenegro"},
                {:id=>142,:iso=>"MF",:name=>"Saint Martin"},
                {:id=>143,:iso=>"MG",:name=>"Madagascar"},
                {:id=>144,:iso=>"MH",:name=>"Marshall Islands"},
                {:id=>145,:iso=>"MK",:name=>"Macedonia"},
                {:id=>146,:iso=>"ML",:name=>"Mali"},
                {:id=>147,:iso=>"MM",:name=>"Myanmar"},
                {:id=>148,:iso=>"MN",:name=>"Mongolia"},
                {:id=>149,:iso=>"MO",:name=>"Macao"},
                {:id=>150,:iso=>"MP",:name=>"Northern Mariana Islands"},
                {:id=>151,:iso=>"MQ",:name=>"Martinique"},
                {:id=>152,:iso=>"MR",:name=>"Mauritania"},
                {:id=>153,:iso=>"MS",:name=>"Montserrat"},
                {:id=>154,:iso=>"MT",:name=>"Malta"},
                {:id=>155,:iso=>"MU",:name=>"Mauritius"},
                {:id=>156,:iso=>"MV",:name=>"Maldives"},
                {:id=>157,:iso=>"MW",:name=>"Malawi"},
                {:id=>158,:iso=>"MX",:name=>"Mexico"},
                {:id=>159,:iso=>"MY",:name=>"Malaysia"},
                {:id=>160,:iso=>"MZ",:name=>"Mozambique"},
                {:id=>161,:iso=>"NA",:name=>"Namibia"},
                {:id=>162,:iso=>"NC",:name=>"New Caledonia"},
                {:id=>163,:iso=>"NE",:name=>"Niger"},
                {:id=>164,:iso=>"NF",:name=>"Norfolk Island"},
                {:id=>165,:iso=>"NG",:name=>"Nigeria"},
                {:id=>166,:iso=>"NI",:name=>"Nicaragua"},
                {:id=>167,:iso=>"NL",:name=>"Netherlands"},
                {:id=>168,:iso=>"NO",:name=>"Norway"},
                {:id=>169,:iso=>"NP",:name=>"Nepal"},
                {:id=>170,:iso=>"NR",:name=>"Nauru"},
                {:id=>171,:iso=>"NU",:name=>"Niue"},
                {:id=>172,:iso=>"NZ",:name=>"New Zealand"},
                {:id=>173,:iso=>"OM",:name=>"Oman"},
                {:id=>174,:iso=>"PA",:name=>"Panama"},
                {:id=>175,:iso=>"PE",:name=>"Peru"},
                {:id=>176,:iso=>"PF",:name=>"French Polynesia"},
                {:id=>177,:iso=>"PG",:name=>"Papua New Guinea"},
                {:id=>178,:iso=>"PH",:name=>"Philippines"},
                {:id=>179,:iso=>"PK",:name=>"Pakistan"},
                {:id=>180,:iso=>"PL",:name=>"Poland"},
                {:id=>181,:iso=>"PM",:name=>"Saint Pierre and Miquelon"},
                {:id=>182,:iso=>"PN",:name=>"Pitcairn"},
                {:id=>183,:iso=>"PR",:name=>"Puerto Rico"},
                {:id=>184,:iso=>"PS",:name=>"Palestinian Territory"},
                {:id=>185,:iso=>"PT",:name=>"Portugal"},
                {:id=>186,:iso=>"PW",:name=>"Palau"},
                {:id=>187,:iso=>"PY",:name=>"Paraguay"},
                {:id=>188,:iso=>"QA",:name=>"Qatar"},
                {:id=>189,:iso=>"RE",:name=>"Reunion"},
                {:id=>190,:iso=>"RO",:name=>"Romania"},
                {:id=>191,:iso=>"RS",:name=>"Serbia"},
                {:id=>192,:iso=>"RU",:name=>"Russia"},
                {:id=>193,:iso=>"RW",:name=>"Rwanda"},
                {:id=>194,:iso=>"SA",:name=>"Saudi Arabia"},
                {:id=>195,:iso=>"SB",:name=>"Solomon Islands"},
                {:id=>196,:iso=>"SC",:name=>"Seychelles"},
                {:id=>197,:iso=>"SD",:name=>"Sudan"},
                {:id=>198,:iso=>"SE",:name=>"Sweden"},
                {:id=>199,:iso=>"SG",:name=>"Singapore"},
                {:id=>200,:iso=>"SH",:name=>"Saint Helena"},
                {:id=>201,:iso=>"SI",:name=>"Slovenia"},
                {:id=>202,:iso=>"SJ",:name=>"Svalbard and Jan Mayen"},
                {:id=>203,:iso=>"SK",:name=>"Slovakia"},
                {:id=>204,:iso=>"SL",:name=>"Sierra Leone"},
                {:id=>205,:iso=>"SM",:name=>"San Marino"},
                {:id=>206,:iso=>"SN",:name=>"Senegal"},
                {:id=>207,:iso=>"SO",:name=>"Somalia"},
                {:id=>208,:iso=>"SR",:name=>"Suriname"},
                {:id=>209,:iso=>"ST",:name=>"Sao Tome and Principe"},
                {:id=>210,:iso=>"SV",:name=>"El Salvador"},
                {:id=>211,:iso=>"SX",:name=>"Sint Maarten"},
                {:id=>212,:iso=>"SY",:name=>"Syria"},
                {:id=>213,:iso=>"SZ",:name=>"Swaziland"},
                {:id=>214,:iso=>"TC",:name=>"Turks and Caicos Islands"},
                {:id=>215,:iso=>"TD",:name=>"Chad"},
                {:id=>216,:iso=>"TF",:name=>"French Southern Territories"},
                {:id=>217,:iso=>"TG",:name=>"Togo"},
                {:id=>218,:iso=>"TH",:name=>"Thailand"},
                {:id=>219,:iso=>"TJ",:name=>"Tajikistan"},
                {:id=>220,:iso=>"TK",:name=>"Tokelau"},
                {:id=>221,:iso=>"TL",:name=>"East Timor"},
                {:id=>222,:iso=>"TM",:name=>"Turkmenistan"},
                {:id=>223,:iso=>"TN",:name=>"Tunisia"},
                {:id=>224,:iso=>"TO",:name=>"Tonga"},
                {:id=>225,:iso=>"TR",:name=>"Turkey"},
                {:id=>226,:iso=>"TT",:name=>"Trinidad and Tobago"},
                {:id=>227,:iso=>"TV",:name=>"Tuvalu"},
                {:id=>228,:iso=>"TW",:name=>"Taiwan"},
                {:id=>229,:iso=>"TZ",:name=>"Tanzania"},
                {:id=>230,:iso=>"UA",:name=>"Ukraine"},
                {:id=>231,:iso=>"UG",:name=>"Uganda"},
                {:id=>232,:iso=>"UM",:name=>"United States Minor Outlying Islands"},
                {:id=>233,:iso=>"US",:name=>"United States"},
                {:id=>234,:iso=>"UY",:name=>"Uruguay"},
                {:id=>235,:iso=>"UZ",:name=>"Uzbekistan"},
                {:id=>236,:iso=>"VA",:name=>"Vatican"},
                {:id=>237,:iso=>"VC",:name=>"Saint Vincent and the Grenadines"},
                {:id=>238,:iso=>"VE",:name=>"Venezuela"},
                {:id=>239,:iso=>"VG",:name=>"British Virgin Islands"},
                {:id=>240,:iso=>"VI",:name=>"U.S. Virgin Islands"},
                {:id=>241,:iso=>"VN",:name=>"Vietnam"},
                {:id=>242,:iso=>"VU",:name=>"Vanuatu"},
                {:id=>243,:iso=>"WF",:name=>"Wallis and Futuna"},
                {:id=>244,:iso=>"WS",:name=>"Samoa"},
                {:id=>245,:iso=>"YE",:name=>"Yemen"},
                {:id=>246,:iso=>"YT",:name=>"Mayotte"},
                {:id=>247,:iso=>"ZA",:name=>"South Africa"},
                {:id=>248,:iso=>"ZM",:name=>"Zambia"},
                {:id=>249,:iso=>"ZW",:name=>"Zimbabwe"},
                {:id=>250,:iso=>"CS",:name=>"Serbia and Montenegro"},
                {:id=>251,:iso=>"AN",:name=>"Netherlands Antilles"}
              ]
  process_char = ["|","/","-","|","-","\\"]
  total = countries.length.to_f
  process_counter = 0
  process_display = 0
  countries.each do |country|
    Country.create(country)
    process_counter+=1
    percent = ((process_counter/total) * 100).round(1)
    display = process_char[process_display]
    process_display= (process_display == 5 ? 0 : (process_display + 1))
    print "\r\rCreating countries #{percent}% #{display}"
  end
  print "\n"
end

user = if User.count == 0
  User.create(email: "admin@clim.org", password: "12345678", password_confirmation: "12345678")
else
  User.first
end

org = if Organization.count == 0
  puts "Creating Organizations..."
  Organization.create(name: "ClimaOrg", country_id: Country.first.id)
else
  Organization.first
end

if user.organizations.count == 0
  user.organizations << org
end

if DemographicVariable.count == 0
  puts "Creating Demographic Variables..."
  DemographicVariable.create(
    name: 'Edad',
    is_default: true,
    user_id: user.id,
    display_values: '"edad1":"18-25","edad2":"25-30","edad3":"30-35","edad4":"35-50"'
  )
  DemographicVariable.create(
    name: 'Sexo',
    is_default: true,
    user_id: user.id,
    display_values: 'Masculino|Femenino',
  )
end

if Dimension.count == 0
  puts "Creating Dimensions..."
  Dimension.create(name: 'Dimension 1', is_default: true, user_id: user.id)
  Dimension.create(name: 'Dimension 2', is_default: true, user_id: user.id)
  Dimension.create(name: 'Dimension 3', is_default: true, user_id: user.id)
  Dimension.create(name: 'Dimension 4', is_default: true, user_id: user.id)
  Dimension.create(name: 'Dimension 5', is_default: true, user_id: user.id)
end




def create_questions_for_research(research)
  puts "Creating Questions..."
  dimensions = research.dimensions
  (1..10).each do |i|
    Question.create(
      research_id: research.id,
      dimension_id: dimensions.sample.id,
      description: Faker::Quote.yoda,
      ordinal: i
    )
  end
end

def create_employees_for_research(research)
  puts "Creating Employees..."
  evaluations = (1..10).map do |i|
    employee = Employee.create(
      organization_id: research.organization_id,
      name: Faker::Name.name,
      email: Faker::Internet.email,
      has_evaluated_research: false
    )
    Evaluation.new(employee_id: employee.id, access_token: SecureRandom.hex(32), access_sent: Date.today)
  end
  research.evaluations << evaluations
end

if Research.count == 0
  puts "Creating Researches..."
  ActiveRecord::Base.transaction do
    # Created Research
    r1 = Research.create(
      user_id: user.id,
      organization_id: org.id,
      use_virtual_application: true,
      start_date: DateTime.now,
      end_date: 3.month.from_now
    )

    # Configured Research
    r2 = Research.create(
      user_id: user.id,
      organization_id: org.id,
      use_virtual_application: true,
      start_date: DateTime.now,
      end_date: 3.month.from_now
    )

    r2.demographic_variables << DemographicVariable.defaults
    r2.dimensions << Dimension.defaults
    r2.state = 1
    r2.save

    # With Questionnaire
    r3 = Research.create(
      user_id: user.id,
      organization_id: org.id,
      use_virtual_application: true,
      start_date: DateTime.now,
      end_date: 3.month.from_now
    )

    r3.demographic_variables << DemographicVariable.defaults
    r3.dimensions << Dimension.defaults

    create_questions_for_research(r3)
    create_employees_for_research(r3)
    r3.state = 2
    r3.save


    # Confirm Research
    r4 = Research.create(
      user_id: user.id,
      organization_id: org.id,
      use_virtual_application: true,
      start_date: DateTime.now,
      end_date: 3.month.from_now
    )

    r4.demographic_variables << DemographicVariable.defaults
    r4.dimensions << Dimension.defaults

    create_questions_for_research(r4)
    create_employees_for_research(r4)
    r4.confirm!
    rescue ActiveRecord::Rollback
      puts "Error creating researches"
      puts "#{r1.errors.full_messages.join("/n")}" unless r1.valid?
      puts "#{r2.errors.full_messages.join("/n")}" unless r2.valid?
      puts "#{r3.errors.full_messages.join("/n")}" unless r3.valid?
      puts "#{r4.errors.full_messages.join("/n")}" unless r4.valid?
  end
end
