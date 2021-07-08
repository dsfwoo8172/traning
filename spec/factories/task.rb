FactoryBot.define do
  factory :task do
    title {"Anything"}
    start_time {DateTime.now}
    end_time {DateTime.now + 1.week}
    priority {"low"}
    state {"pending"}
  end
end