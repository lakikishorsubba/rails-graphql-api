# factory bot helps to create a pre-made object of sth that we can use directly, its the combo of faker.
# Faker: to randomly create the object attributes.
# Factory bot: takes faker attributes and creates objectg:
# Eg: faker creates user name and email atrribute, while factory bot takes this attribute and creates a user object.

FactoryBot.define do # call module class
  factory :user do  # name of factory and map to User model automatically
    email { Faker::Internet.email } # unique email is generated each time
    password { "Password@123" } # static password
  end
end
