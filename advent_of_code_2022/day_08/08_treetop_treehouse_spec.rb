require 'rspec'
require_relative 'lib/treehouse'

class TreehouseSpec
  describe Forest do
    
    context 'sample file' do
      subject(:forest) { Forest.new('day_08/day_08_sample.txt')}

      it 'builds grid' do
        expect(forest.grid).to eq [
          [3, 0, 3, 7, 3], 
          [2, 5, 5, 1, 2], 
          [6, 5, 3, 3, 2], 
          [3, 3, 5, 4, 9], 
          [3, 5, 3, 9, 0]
        ]
      end

      context '#visible?' do
        it 'allows left edge' do
          expect(forest.visible?(0,2)).to be_truthy
        end

        it 'allows top edge' do
          expect(forest.visible?(3,0)).to be_truthy
        end

        it 'allows bottom edge' do
          expect(forest.visible?(4,1)).to be_truthy
        end

        it 'allows right edge' do
          expect(forest.visible?(2,4)).to be_truthy
        end

        it 'handles height' do
          expect(forest.visible?(1,1)).to be_truthy
        end
      end

      context '#sum_visible' do
        it 'calculates sum of visible trees' do
          expect(forest.sum_visible).to eq 21
        end
      end

      context '#distance' do
        it 'calculates visible distance' do
          expect(forest.distance(1,2)).to eq [1, 1, 2, 2]
          expect(forest.scenic_score(1,2)).to eq 4
        end
      end
    end

    context 'input file' do
      subject(:forest) { Forest.new('day_08/day_08_input.txt')}

      it 'calculates sum of visible trees' do
        expect(forest.sum_visible).to eq 1736
      end

      it 'calculates max scenic score' do
        expect(forest.max_scenic_score).to eq 268_800
      end
    end
    
  end

end