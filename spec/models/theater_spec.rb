require 'rails_helper'

RSpec.describe Theater, type: :model do
  it { should have_valid(:name).when("Regal") }
  it { should_not have_valid(:name).when(nil, "") }

  it { should have_valid(:address).when("555 N Fifth St") }
  it { should_not have_valid(:address).when(nil, "") }

  it { should have_valid(:city).when("Hoboken") }
  it { should_not have_valid(:city).when(nil, "") }

  it { should have_valid(:state).when("New Jersey") }
  it { should_not have_valid(:state).when(nil, "") }

  it { should have_valid(:zip).when("02917") }
  it { should_not have_valid(:zip).when(nil, "") }

  describe ".search" do
    it "returns results relevant to search" do
      Theater.search('<theater that exists>')
    end
  end
end
