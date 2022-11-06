FactoryBot.define do
  factory :task do
    name { 'タスク１' }
    content { 'コンテント１' }
    finish_on { '2022-10-31' }
    priority {1}
    
    after(:build) do |task|
      label = create(:label)
      task.task_labels << build(:task_label, task: task, label: label)
    end
  end
  # factory :second_task, class: Task do
  #   name { 'タスク２' }
  #   content { 'コンテント２' }
  #   finish_on { '2022-10-29' }
  #   priority {2}
  # end
end