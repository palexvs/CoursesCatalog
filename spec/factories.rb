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
    link 'http://test.com'
    # created_by :created_by
    publish_status "publish"

    factory :course_draft do
      publish_status "draft"
    end

    factory :course_pending do
      publish_status "pending"
    end

  end

  factory :start_date do
    start_on (Date.today).to_s(:db)
    publish_status "publish"
  end

  factory :track_it do
  end

end