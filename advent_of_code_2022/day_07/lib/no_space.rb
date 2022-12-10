require 'pathname'
require_relative 'file_record'

class NoSpace
  attr_reader :listing, :files, :folders

  def initialize(listing)
    @listing = listing
    @files, @folders = parse
  end

  def find(item)
    result = @files.filter{ |f| f.name.start_with?(item) }
    # pp "find: #{result}"
    result
  end

  def folder_sums
    result = {}
    @folders.each do |f|
      result[f] = total(f)
    end
    result
  end

  def folders_under_100k_sums
    folder_sums().filter { |k,v| v < 100000 }
  end

  def total(item)
    result = find(item)
              .reduce(0) do |sum, i|
                # pp "total: add #{i.name} to #{sum} = #{sum + i.size}"
                sum += i.size
              end
    # pp "total: end result: #{result}"
    result
  end

  private

  def parse
    files = []
    folders = []
    current_folder = Pathname.new("/")
    folders << current_folder.to_s
    File.open(listing).lines.each do |line|
      # pp "DEBUG: line: '#{line.chomp}', current_folder: #{current_folder}"
      tokens = line.chomp.split(" ")
      first_token = tokens.shift
      case first_token
      when "$"
        command = tokens.shift
        case command
        when "cd"
          folder_name = tokens.shift
          case folder_name
          when ".."
            current_folder = current_folder.parent
          else
            current_folder += folder_name
            folders << current_folder.to_s
          end
        when "ls"
          next
        end
      when "dir"
        folders << (Pathname.new(current_folder) + tokens.first).to_s
      else
        size = first_token
        name = Pathname.new(current_folder) + tokens.first
        new_file = FileRecord.new(name.to_s, size)
        files << new_file
      end
    end
    [files, folders.uniq]
  end
end