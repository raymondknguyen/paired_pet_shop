require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it {should belong_to :pets}
    it {should belong_to :applications}
  end
end
