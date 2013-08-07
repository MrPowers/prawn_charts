require "spec_helper"

module PrawnCharts
  describe XLabelsDataCollector do
    before do
      input_data = [["Jan 11", 5], ["Feb 11", 2], ["Mar 11", 12]]
      graph_width_pdf = 160
      vertical_offset = 20
      label_width = 50
      @x_labels_data_collector = XLabelsDataCollector.new(input_data, graph_width_pdf, vertical_offset, label_width)
    end

    context "#collect" do
      it "returns array of labels and [x, y] coordinate where the label should be plotted" do
        expected = [["Jan 11", [-25.0, -20]], ["Feb 11", [55.0, -20]], ["Mar 11", [135.0, -20]]]
        expect(@x_labels_data_collector.collect).to eq(expected)
      end
    end
  end
end
