require 'rspec'
require_relative 'lib/tuning'

class TuningSpec
  describe Tuning do
    context 'part 1' do
      SAMPLES = { 
        'mjqjpqmgbljsphdztnvjfqwrcgsmlb': 7,
        'bvwbjplbgvbhsrlpgdmjqwftvncz': 5,
        'nppdvjthqldpwncqszvftbrmjlhg': 6,
        'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg': 10,
        'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw': 11
      }

      SAMPLES.keys.each do |key|
        message = key.to_s
        it "can find packet start for #{message}" do
          expect(Tuning.new(message).packet_start).to eq SAMPLES[key]
        end
      end

      it "can find packet start for input" do
        message = File.read('day_06/day_06_input.txt')
        expect(Tuning.new(message).packet_start).to eq 1909
      end
    end

    context 'part 2' do
      SAMPLES2 = { 
        'mjqjpqmgbljsphdztnvjfqwrcgsmlb': 19,
        'bvwbjplbgvbhsrlpgdmjqwftvncz': 23,
        'nppdvjthqldpwncqszvftbrmjlhg': 23,
        'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg': 29,
        'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw': 26
      }

      SAMPLES2.keys.each do |key|
        message = key.to_s
        it "can find packet start for #{message}" do
          expect(Tuning.new(message).message_start).to eq SAMPLES2[key]
        end
      end

      it "can find packet start for input" do
        message = File.read('day_06/day_06_input.txt')
        expect(Tuning.new(message).message_start).to eq 3380
      end
    end
  end
end