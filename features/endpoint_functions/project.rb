require 'rest-client'
require 'test-unit' #vajag priekš assert_equal

def create_project
  randomnr = 1 + rand(1000)

  project_payload = {:name => 'Test' + randomnr.to_s,
                     :type => 'basic'}.to_json

  response = post("https://www.apimation.com/projects",
                  headers: {'Content-Type' => 'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: project_payload)

  assert_equal(200, response.code, "Failed to create project! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal(name, response_hash['name'], 'Project name is not correct')

  assert_equal(type, response_hash['type'], 'Project type is not correct')
end

def check_if_project_created
  puts 'Some code goes here'
end


def create_prod_env
  randomnr = 1 + rand(1000)

  project_payload = {:name => 'Prod' + randomnr.to_s}.to_json

  response = post("https://www.apimation.com/environments",
                  headers: {'Content-Type' => 'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: project_payload)

  assert_equal(200, response.code, "Failed to create prod environment! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal(name, response_hash['name'], 'Prod environment name is not correct')
end

def check_prod_env
  puts 'Some code goes here'
end



def create_dev_env
  randomnr = 1 + rand(1000)

  project_payload = {:name => 'Dev' + randomnr.to_s}.to_json

  response = post("https://www.apimation.com/environments",
                  headers: {'Content-Type' => 'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: project_payload)

  assert_equal(200, response.code, "Failed to create dev environment! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal(name, response_hash['name'], 'Dev environment name is not correct')
end

def check_dev_env
  puts 'Some code goes here'
end


def add_global1
  randomnr = 1 + rand(1000)

  project_payload = {:key => "$global" + randomnr, :value => "global1" + randomnr}.to_json

  response = put("https://www.apimation.com/environments/0ede8100-e4eb-11e7-8bcd-5d3e2d5d7554",
                  headers: {'Content-Type' => 'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: project_payload)

  assert_equal(200, response.code, "Failed to first global values! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal(key, response_hash['key'], 'Key for first global value is not correct')
end

def add_global2
  randomnr = 1 + rand(1000)

  project_payload = {:key => "$global" + randomnr, :value => "global1" + randomnr}.to_json

  response = put("https://www.apimation.com/environments/0ede8100-e4eb-11e7-8bcd-5d3e2d5d7554",
                 headers: {'Content-Type' => 'application/json'},
                 cookies: @test_user.session_cookie,
                 payload: project_payload)

  assert_equal(200, response.code, "Failed to second global values! Response: #{response}")

  response_hash = JSON.parse(response)

  assert_equal(key, response_hash['key'], 'Key for second global value is not correct')
end