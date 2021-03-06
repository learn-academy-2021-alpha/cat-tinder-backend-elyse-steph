require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it 'gets a list of Cats' do
      Cat.create(name:'Tigger', age:20, enjoys:'bouncing around')

      get '/cats'

      cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat_response.length).to eq 1
      first_cat = cat_response.first
      expect(first_cat['name']).to eq 'Tigger'
      expect(first_cat['age']).to eq 20
      expect(first_cat['enjoys']).to eq 'bouncing around'
    end
  end

  describe 'POST /cats' do
    it 'creates a cat' do
      cat_params = {
        cat: {
          name:'Bagheera',
          age:54,
          enjoys:'mentoring Mowgli'
        }
      }

      post '/cats', params: cat_params

      cat = Cat.first
      expect(cat.name).to eq 'Bagheera'
      expect(cat.age).to eq 54
      expect(cat.enjoys).to eq 'mentoring Mowgli'

      cat_response = JSON.parse(response.body)
      expect(cat_response['name']).to eq 'Bagheera'
      expect(cat_response['age']).to eq 54
      expect(cat_response['enjoys']).to eq 'mentoring Mowgli'
    end

  it "Doesn't create a cat without a name" do
    cat_params = {
      cat: {
        age: 5,
        enjoys: "Swatting dogs"
      }
    }

    post "/cats", params: cat_params

    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json["name"]).to include "can't be blank"
  end
end

  describe 'PUT /cats/' do
    it "updates a cat" do
      cat = Cat.create name: 'Garfield', age: 1, enjoys: 'eating lasagna'
      update_cat_params = {
        cat: {
          name:'Arlo',
          age: 20,
          enjoys:'chasing after many birds'
        }
      }
      put "/cats/#{cat.id}", params: update_cat_params

      update_cat_response = JSON.parse(response.body)
      expect(update_cat_response['name']).to eq 'Arlo'
      expect(update_cat_response['age']).to eq 20
      expect(update_cat_response['enjoys']).to eq 'chasing after many birds'
      expect(response).to have_http_status(200)

    end
  end

  describe 'DELETE /cats/' do
    it "deletes a cat" do
      cat = Cat.create name: 'Garfield', age: 1, enjoys: 'eating lasagna'

      delete "/cats/#{cat.id}"

      no_cat = Cat.where(id: cat.id)
      expect(no_cat).to be_empty

      delete_cat_response = JSON.parse(response.body)
      expect(delete_cat_response['name']).to eq 'Garfield'
      expect(delete_cat_response['age']).to eq 1
      expect(delete_cat_response['enjoys']).to eq 'eating lasagna'
      expect(response).to have_http_status(200)
    end
  end
end
