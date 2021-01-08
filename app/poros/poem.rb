class Poem
  attr_reader :author,
              :title,
              :lines

  def initialize(poem_data, ibm_data)
    @author = poem_data[:author]
    @title = poem_data[:title]
    @lines = poem_data[:lines].join(" ")
  end
end
