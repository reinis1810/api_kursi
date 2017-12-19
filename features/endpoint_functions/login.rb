require 'rest-client'
require 'test-unit' #vajag priekš assert_equal

def login_positive
  login_payload = {:login => @test_user.email,
                   :password => @test_user.password}.to_json

  response = post("https://www.apimation.com/login",
                  headers: {'Content-Type' => 'application/json'},
                  cookies: {},
                  payload: login_payload)

  #response = RestClient::Request.execute(method: :post,
  #                                        url: "https://www.apimation.com/login",
  #                                        headers: {'Content-Type' => 'application/json'},
  #                                        cookies: {},
  #                                        payload: login_payload)

  #Check if 200 OK is received (kas vajag, kas ir, fail message just in case)
  assert_equal(200, response.code, "Login failed! Response: #{response}")

  #pārveido no json uz hash, lai var lietot tālāk
  response_hash = JSON.parse(response)

  #Check if the emails match (kas vajag, ko dabū, error message ja nofeilo)
  assert_equal(@test_user.email, response_hash['email'], 'Email in the response is not correct')

  #pārbauda vai nav nulle
  assert_not_equal(nil, response_hash['user_id'], 'User id is empty')

  #Check if the logins match (kas vajag, ko dabū, error message ja nofeilo)
  assert_equal(@test_user.email, response_hash['login'], 'Login in the response is not correct')

  @test_user.set_session_cookie(response.cookies)

  @test_user.set_user_id(response_hash['user_id']);

  #debug messages
  #puts @test_user.user_id
  #puts @test_user.session_cookie
end



def check_personal_info
  response = get("https://www.apimation.com/user",
                 headers: {},
                 cookies: @test_user.session_cookie)

  #response = RestClient::Request.execute(method: :get,
  #                                       url: "http://apimation.com/user",
  #                                       headers: {},
  #                                       cookies: @test_user.session_cookie)

  assert_equal(200, response.code, "Login failed! Response: #{response}")

  #pārveido no json uz hash, lai var lietot tālāk
  #user_response_hash = JSON.parse(response)

  #pārbauda vai email response ir pareizs
  #assert_equal(@test_user.email, response_hash['email'], 'The email in response is not correct')

  #pārbauda vai user id ir pareizs
  #assert_equal(@test_user.user_id, response_hash['user_id'], 'The user id in response is not correct')
end



def login_wrong_password
  login_payload = {:login => @test_user.email,
                   :password => 'nepareiza parole'}.to_json

  #api_helper restclient vietā, jo restclient prasa atgriezt 200, bet šim keisam vajag 400
  response = post("https://www.apimation.com/login",
                  headers: {'Content-Type' => 'application/json'},
                  cookies: {},
                  payload: login_payload)  #vērtībs ko likt skat. no api_helper headera

  #Check if 400 is received (kas vajag, kas ir, fail message just in case)
  assert_equal(400, response.code, "Wrong error code received! Response: #{response}")

  #pārveido no json uz hash, lai var lietot tālāk
  response_hash = JSON.parse(response)

  assert_equal('002', response_hash['error-code'], 'Error code response is not correct')

  assert_equal('Username or password is not correct', response_hash['error-msg'], 'Error message is not correct')

  @test_user.set_session_cookie(response.cookies)
end



def check_user_not_logged
  response = get("https://www.apimation.com/user",
                 headers: {},
                 cookies: {})

  #Check if 400 is received (kas vajag, kas ir, fail message just in case)
  assert_equal(400, response.code, "Wrong error code received! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal('001', response_hash['error-code'], 'Error code response is not correct')

  assert_equal('No session', response_hash['error-msg'], 'Error message is not correct')
end