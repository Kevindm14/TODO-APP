require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:tasks) { create(:task) }

  describe "GET #index" do
    it "redirect to index" do
      get :index
      expect(JSON.parse(response.body)).to eq([])
    end
  end

  describe "POST #create" do
    context "With valid attributes" do
      it "Save data in database" do
        expect{post :create, params: {task: attributes_for(:task)}}.to change(Task, :count).by(1)
      end
    end

    context "With invalid attributes" do
      it "Not save in database" do
        expect{post :create, params: {task: attributes_for(:invalid_task)}}.to change(Task, :count).by(0)
      end
    end
  end

  describe "GET #update" do
    before { patch :update, params: {id: tasks, task: attributes_for(:task)} }
      
    it "locates the requested @tournament" do
      expect(assigns(:task)).to eq (tasks) 
    end

    it "changes user's attributes" do
      tasks.reload
      expect(tasks.title).to eq('Surf')
    end
  end

  describe "DELETE #destroy" do
    let!(:destroy_task) { create(:task) }

    it "Delete task" do
      expect{delete :destroy, params: { id: destroy_task }}.to change(Task, :count).by(-1)
    end
  end
end
