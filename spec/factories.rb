FactoryGirl.define do
  factory :user do
    email    "test@test.com"
    password "testtest"
  end

  factory :course do 
    name "Algorithms: Design and Analysis, Part 2"
    desc ""
  end

end