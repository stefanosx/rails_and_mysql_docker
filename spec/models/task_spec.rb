require 'rails_helper'

describe Task, type: :model do

  context "fails validation" do
    it "with no subject" do
      expect(Task.new(subject: nil, name: "Test")).to_not be_valid
    end

    it "with no name" do
      expect(Task.new(subject: "Test", name: nil)).to_not be_valid
    end
  end

  context "success validation" do
    before(:each) do
      @task = Task.new(subject: "Test Subject", name: "Test Task 1", complete: true, completed_at: "2017-01-01 00:00:00")
    end

    it "should have a subject" do
      expect(@task.subject).to eq ("Test Subject")
    end

    it "should have a name" do
      expect(@task.name).to eq("Test Task 1")
    end

    it "should have marked as complete" do
      expect(@task.complete).to eq(true)
    end

    it "should have completed at time" do
      expect(@task.completed_at).to eq("2017-01-01 00:00:00")
    end
  end

  describe "#searchable" do
    before(:context) do
      @task1  = Task.new(subject: "Amazing Subject", name: "Amazing Task", completed_at: "2017-01-01 00:00:00")
      @task1.save!
      @task2 = Task.new(subject: "Awesome Subject", name: "Awesome Task", complete: true, completed_at: "2017-01-01 00:00:00")
      @task2.save!
    end
    after(:context) do
      Task.delete_all
    end
    context "search with search term" do
      it "should return searchable results that matches search term" do
        expect(Task.searchable("Amazing Task").first).to eq(@task1)
        expect(Task.searchable("Awesome Subject").first).to eq(@task2)
      end

      it "should return nil as result for non-matching search" do
        expect(Task.searchable("Task Not Found").first).to eq(nil)
      end
    end
  end
end