require "spec_helper"

describe ContainerDataCollector do
  before do
    graph_height = 300
    graph_width = 200
    container_x_padding = 20
    y_label_width = 75
    y_label_offset = 15
    container_y_padding = 20
    x_label_height = 30
    @container_data_collector = ContainerDataCollector.new(graph_height, graph_width, container_x_padding, y_label_width, y_label_offset, container_y_padding, x_label_height)
  end

  context "#height" do
    it "returns the pdf_height of the graph container" do
      expect(@container_data_collector.height).to eq(370)
    end
  end

  context "#width" do
    it "returns the pdf_width of the graph container" do
      expect(@container_data_collector.width).to eq(330)
    end
  end

  context "#graph_top_left_corner" do
    it "returns the point for the top-left corner of the graph" do
      expect(@container_data_collector.graph_top_left_corner).to eq([110, 350])
    end
  end
end
