class FileRecord
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size.to_i
  end

  def to_s
    "FileRecord('#{@name}', #{@size})"
  end

  def ==(other)
    @name == other.name &&
      @size == other.size
  end
end
