require "spec_helper"

describe HorizontalLinesDataCollector do
  before do
    graph_height_pdf = 60
    y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000]
    @horizontal_lines_data_collector = HorizontalLinesDataCollector.new(graph_height_pdf, y_labels)
  end

  context "#y_label_increment" do
    it "calculates the pdf points between every y_label" do
      expect(@horizontal_lines_data_collector.y_label_increment).to eq(10)
    end
  end

  context "#collect" do
    it "returns an array with the start, end, and y position of the horizontal line" do
      expected = [[0, 60, 0.0], [0, 60, 10.0], [0, 60, 20.0], [0, 60, 30.0], [0, 60, 40.0], [0, 60, 50.0], [0, 60, 60.0]]
      expect(@horizontal_lines_data_collector.collect).to eq(expected)
    end
  end
end
