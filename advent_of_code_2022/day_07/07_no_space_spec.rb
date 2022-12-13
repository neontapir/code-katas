require 'rspec'
require_relative 'lib/file_record'
require_relative 'lib/no_space'


describe FileRecord do
  it 'has a size' do
    file = FileRecord.new('a.txt', 5000)

    expect(file.size).to eq 5000
  end
end

describe NoSpace do

  context 'sample file' do
    subject(:filesystem) { NoSpace.new('day_07/day_07_sample.txt') }

    it 'can find the size of a file' do
      file = filesystem.find("/b.txt")
      expect(file).to eq [FileRecord.new("/b.txt", 14848514)]
      expect(file.first.size).to eq 14848514
    end

    it 'can find the size of a folder' do
      expect(filesystem.total("/a/e")).to eq 584
      expect(filesystem.total("/a")).to eq 94853
      expect(filesystem.total("/")).to eq 48381165
    end

    it 'can find the size of folders under 100k' do
      expected = {"/"=>48381165, "/a"=>94853, "/a/e"=>584, "/d"=>24933642}
      expect(filesystem.folder_sums).to eq expected
      filtered = {"/a"=>94853, "/a/e"=>584}
      expect(filesystem.folders_under_100k_sums).to eq filtered
      expect(filesystem.folders_under_100k_sums.values.sum).to eq (94853 + 584)
    end
  end

  context 'input file' do
    subject(:filesystem) { NoSpace.new('day_07/day_07_input.txt') }
    
    it 'can find the size of folders under 100k' do
      expect(filesystem.folders_under_100k_sums.values.sum).to eq 1555642
    end
  end

  context 'part 2 sample' do
    subject(:filesystem) { NoSpace.new('day_07/day_07_sample.txt') }

    it 'can find the smaller folder to delete to make room' do
      target = 8_381_165
      folder_sums = filesystem.folder_sums
      expect(folder_sums.filter{ |_,v| v > target}.sort_by{|a,b| b}.first[0]).to eq "/d"
    end
  end

  context 'part 2 input' do
    subject(:filesystem) { NoSpace.new('day_07/day_07_input.txt') }

    it 'can find the smaller folder to delete to make room' do
      folder_sums = filesystem.folder_sums
      unused_space = 70_000_000 - folder_sums["/"]
      expect(unused_space).to eq 24_650_017

      space_needed = 30_000_000 - unused_space
      expect(space_needed).to eq 5_349_983

      big_enough_folders = folder_sums.filter{|_,v| v > space_needed}.sort_by{|_,b| b}
      size_of_smallest = big_enough_folders.first[1]
      expect(size_of_smallest).to eq 5_974_547
    end
  end
  
end