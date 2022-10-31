FactoryBot.define do
  factory :task do
    name { 'タスク１' }
    content { 'コンテント１' }
  end
  factory :second_task, class: Task do
    name { 'タスク２' }
    content { 'コンテント２' }
  end
end