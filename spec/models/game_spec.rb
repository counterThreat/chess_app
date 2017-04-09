require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associate_pieces!' do
    before(:each) do
      @game = create(:game)
    end

    it 'associates the pieces with the color of the respective player as white or black' do
      # need piece model and controller to be more fleshed out to write this test
    end
  end
end
