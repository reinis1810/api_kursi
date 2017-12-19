Before() do
  puts "Before hook. This will work before every test case"
  #pievieno vērtības test userim
  @test_user = User.new('reinistdl@gmail.com', 'Parole123')
end