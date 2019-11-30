require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  let(:headers) { valid_headers }
  let!(:tasks) { create_list(:task, 10) }
  let(:task_id) { tasks.first.id }

  describe 'get /tasks' do
    before { get '/tasks', headers: headers }

    it 'return tasks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /tasks' do
    let(:valid_params) {{ title: 'My Task' }}

    context 'when the request is valid' do
      before { post '/tasks', params: valid_params.to_json, headers: headers }
      
      it 'creates a task' do
        expect(response).to have_http_status :created
        expect(json['title']).to eq('My Task')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/tasks', params: { title: '' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match("{\"title\":[\"can't be blank\"]}")
      end
    end
  end

  describe 'PUT /tasks/:id' do
    let(:valid_attributes) { { title: 'Random Music' } }

    context 'when the record exists' do
      before { put "/tasks/#{task_id}", params: valid_attributes.to_json, headers: headers }

      it 'updates the record' do
        expect(response.body).to_not be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /tasks/:id' do
    before { delete "/tasks/#{task_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end