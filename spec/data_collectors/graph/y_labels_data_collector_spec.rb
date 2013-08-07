require "spec_helper"

describe YLabelsDataCollector do
  before do
    y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000]
    graph_height_pdf = 560
    label_width = 15
    label_height = 20
    y_label_offset = 30
    @y_data_collector = YLabelsDataCollector.new(y_labels, graph_height_pdf, label_width, label_height, y_label_offset)
  end

  context "#collect" do
    it "returns an array of y_labels and points where they should be plotted" do
      expected = [["0", [-45, 10.0]], ["10", [-45, 90.0]], ["100", [-45, 170.0]], ["1,000", [-45, 250.0]], ["10,000", [-45, 330.0]], ["100,000", [-45, 410.0]], ["1,000,000", [-45, 490.0]], ["10,000,000", [-45, 570.0]]]
      expect(@y_data_collector.collect).to eq(expected)
    end
  end
end
