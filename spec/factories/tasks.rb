#spec/factories/tasks.rb
FactoryGirl.define do
  factory :task do
    after :create do |task|
      task.task_search = [task.subject, task.name, task.complete ? "complete" : "incomplete"].join(",")
    end
  end
end