class Task < ApplicationRecord
  validates :subject, presence: true
  validates :name, presence: true
  before_save do
    self.task_search = [self.subject, self.name, self.complete ? "complete" : "incomplete"].join(",")
  end

  def self.searchable(search_term)
    Task.where("(MATCH(task_search) AGAINST(?))", "(\"#{search_term}\")")
  end

end
