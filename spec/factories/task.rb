FactoryBot.define do
  factory :task do
    title { "Surf" }
  end

  factory :invalid_task, parent: :task do |f|
    f.title { nil }
  end
end