User.create!(name:  "Admin",
             email: "admin@ad.com",
             password:              "123123",
             password_confirmation: "123123",
             role: 1)

30.times do |n|
  name  = Faker::Name.name
  email = "ex-#{n+1}@ex.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
