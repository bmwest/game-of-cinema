require "rails_helper"

RSpec.describe Api::V1::TheatersController, type: :controller do
  describe "GET #index" do
    let!(:theater1) { Theater.create(name:"test theater1", address:"1 Street", city:"1 City", state:"1 State", zip: 12345, user_id: 1) }
    let!(:theater2) { Theater.create(name:"test theater2", address:"2 Street", city:"2 City", state:"2 State", zip: 12345, user_id: 1) }

    it "should return all theaters" do
      get :index
      json = JSON.parse(response.body)

      expect(json["theaters"].length).to eq(2)
      expect(json["theaters"][0]["name"]).to eq("test theater1")
      expect(json["theaters"][1]["name"]).to eq("test theater2")
    end
  end
end
