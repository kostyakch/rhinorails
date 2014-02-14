namespace :db do
  desc "Fill database with admin user data"
  task populate: :environment do
    User.create!(name: "Admin",
                 email: "admin@test.com",
                 roles: "ROLE_ADMIN",
                 password: "admin",
                 password_confirmation: "admin")
    # 99.times do |n|
    #   name  = Faker::Name.name
    #   email = Faker::Internet.email
    #   password  = "password"
    #   User.create!(name: name,
    #                email: email,
    #                password: password,
    #                password_confirmation: password)
    # end
  end
end