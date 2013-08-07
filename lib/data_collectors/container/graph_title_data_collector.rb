module PrawnCharts
  class GraphTitleDataCollector
    attr_reader :graph_title, :position, :graph_title_height, :graph_title_width
    def initialize(graph_title, position, graph_title_height, graph_title_width)
      @graph_title = graph_title
      @position = position
      @graph_title_height = graph_title_height
      @graph_title_width = graph_title_width
    end

    def collect
      { title: graph_title, at: position, height: graph_title_height, width: graph_title_width }
    end
  end
end
