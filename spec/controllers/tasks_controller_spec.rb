require "rails_helper"

describe TasksController, type: :controller do

  describe "#index" do
    context "when tasks exists" do
      let(:task) {create :task, subject: 'Test Name', name: 'Test Name', complete: false}
      let(:task2) {create :task, subject: 'Test Name 2', name: 'Test Name 2', complete: true}
      it "should assign incomplete tasks to @incomplete_tasks" do
        get :index
        expect(assigns(:incomplete_tasks)).to eq([task])
      end
      it "should assign complete tasks to @complete_tasks" do
        get :index
        expect(assigns(:complete_tasks)).to eq([task2])
      end
    end
  end

  describe "#auto_complete_task" do
    context "when search term is provided" do
      it "should return batch results" do
        get :auto_complete_search
        expect(assigns(:tasks_result)).to eq([])
      end
    end

    context "when search term is empty" do
      it "should return empty results" do
        get :auto_complete_search
        expect(assigns(:tasks_result)).to eq([])
      end
    end
  end

  describe "#new" do
    it "should create new Task instance" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end

    it "should render to new task template" do
      get :new
      expect(response).to redirect_to(new_task_url)
    end
  end

  describe "#create" do
    context "when valid params are provided" do
      let(:task) { {subject: "new subject", name: "new name"} }

      it "should create a new task with valid params" do
        post :create, params: { :task => task }
        expect(response).to redirect_to(tasks_url)
      end
    end

    context "when invalid or no params are provided" do
      let(:task) { {subject: nil, name: "new name"} }
      it "should fail to create new task with invalid params" do
        expect { post :create, params: { :task => task } }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#update" do
    let(:task) { create :task, subject: "new subject", name: "new name" }
    let(:task2) { {subject: "update subject", name: "update name"} }
    it "should update specific task attributes by id" do
      get :update, params: { :id => task.id, :task => task2 }
      expect(response).to redirect_to(tasks_url)
    end
  end

  describe "#destroy" do
    let(:task) { create :task, subject: "new subject", name: "new name" }
    it "should delete specific task by id" do
      get :destroy, params: { :id => task.id }
      expect(response).to redirect_to(tasks_url)
    end
  end

end