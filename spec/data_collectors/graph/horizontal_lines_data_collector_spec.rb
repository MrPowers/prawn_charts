require "spec_helper"

describe HorizontalLinesDataCollector do
  before do
    graph_height_pdf = 60
    graph_width_pdf = 80
    y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000]
    @horizontal_lines_data_collector = HorizontalLinesDataCollector.new(graph_height_pdf, graph_width_pdf, y_labels)
  end

  context "#collect" do
    it "returns an array with the start, end, and y position of the horizontal lines" do
      expected = [[0, 80, 0.0], [0, 80, 10.0], [0, 80, 20.0], [0, 80, 30.0], [0, 80, 40.0], [0, 80, 50.0], [0, 80, 60.0]]
      expect(@horizontal_lines_data_collector.collect).to eq(expected)
    end
  end
end
