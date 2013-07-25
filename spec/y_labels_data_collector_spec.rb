require "spec_helper"

describe YLabelsDataCollector do
  before do
    y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000]
    graph_height_pdf = 400
    horizontal_offset = 20
    @y_data_collector = YLabelsDataCollector.new(y_labels, graph_height_pdf, horizontal_offset)
  end

  context "#y_label_increment" do
    it "calculates the pdf points between y labels" do
      expect(@y_data_collector.y_label_increment).to be_within(0.01).of(57.14)
    end
  end
end
