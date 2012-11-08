FactoryGirl.define do
  factory :user do
    email    "test@test.com"
    password "testtest"
    password_confirmation "testtest"
    role "user"

    factory :admin do
      role "admin"
    end
  end

  factory :course do 
    name "Algorithms: Design and Analysis, Part 2"
    desc ""
    # created_by :created_by
    publish_status "publish"

    factory :course_draft do
      publish_status "draft"
    end

    factory :course_pending do
      publish_status "pending"
    end

  end

end