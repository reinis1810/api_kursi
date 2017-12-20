require 'rest-client'
require 'test-unit' #vajag priekš assert_equal

String dev_env_id = ''
String prod_env_id = ''

def create_project
  randomnr =  Time.now.to_s

  project_payload = {:name => 'Test' + randomnr,
                     :type => 'basic'}.to_json

  response = post("https://www.apimation.com/projects",
                  headers: {'Content-Type' => 'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: project_payload)

  assert_equal(200, response.code, "Failed to create project! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal('Test' + randomnr, response_hash['name'], 'Project name is not correct')

  assert_equal('basic', response_hash['type'], 'Project type is not correct')
end

def check_if_project_created
  puts 'Some code goes here'
end


def create_prod_env
  randomnr =  Time.now.to_s

  project_payload = {:name => 'Prod' + randomnr}.to_json

  response = post("https://www.apimation.com/environments",
                  headers: {'Content-Type' => 'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: project_payload)

  assert_equal(200, response.code, "Failed to create prod environment! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal('Prod' + randomnr, response_hash['name'], 'Prod environment name is not correct')

  prod_env_id = response_hash['id']
end

def check_prod_env
  puts 'Some code goes here'
end



def create_dev_env
  randomnr = Time.now.to_s

  project_payload = {:name => 'Dev' + randomnr}.to_json

  response = post("https://www.apimation.com/environments",
                  headers: {'Content-Type' => 'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: project_payload)

  assert_equal(200, response.code, "Failed to create dev environment! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal('Dev' + randomnr, response_hash['name'], 'Dev environment name is not correct')

  dev_env_id = response_hash['id']
end

def check_dev_env
  puts 'Some code goes here'
end


def add_global1
  randomnr = Time.now.to_s

  project_payload = {:key => '$global1' + randomnr, :value => 'global1' + randomnr}.to_json

  response = put("https://www.apimation.com/environments/" + prod_env_id,
                  headers: {'Content-Type' => 'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: project_payload)

  assert_equal(200, response.code, "Failed to first global values! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal('$global1' + randomnr, response_hash['key'], 'Key for first global value is not correct')
  assert_equal('global1' + randomnr, response_hash['value'], 'Value for first global value is not correct')
end

def add_global2
  randomnr = Time.now.to_s

  project_payload = {:key => '$global2' + randomnr, :value => 'global2' + randomnr}.to_json

  response = put("https://www.apimation.com/environments/" + dev_env_id,
                 headers: {'Content-Type' => 'application/json'},
                 cookies: @test_user.session_cookie,
                 payload: project_payload)

  assert_equal(200, response.code, "Failed to second global values! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal('$global2' + randomnr, response_hash['key'], 'Key for second global value is not correct')
  assert_equal('global2' + randomnr, response_hash['value'], 'Value for second global value is not correct')
end