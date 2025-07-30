FactoryBot.define do
  # Movie
  factory :movie do
    sequence(:title) { |n| "Movie #{n}" }
    description { "A great movie about something interesting." }
    sequence(:release_year) { |n| 2000 + n }

    trait :without_description do
      description { nil }
    end

    trait :without_release_year do
      release_year { nil }
    end
  end

  # User
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    password { "123456" }

    trait :with_uppercase_username do
      sequence(:username) { |n| "USER#{n}" }
    end

    trait :with_spaces_in_username do
      sequence(:username) { |n| "  user#{n}  " }
    end
  end

  # Watchlist
  factory :watchlist do
    association :user
    association :movie
  end
end
