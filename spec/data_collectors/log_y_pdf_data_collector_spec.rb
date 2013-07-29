require "spec_helper"

describe LogYPdfDataCollector do
  before do
    @graph_height_pdf = 60
    @y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000]
  end

  context "#collect" do
    it "returns an array of [x_pdf, y_pdf] for all data points" do
      input_data = [["Jan 11", 5], ["Feb 11", 900], ["Mar 11", 800_000]]
      log_y_pdf_data_collector = LogYPdfDataCollector.new(input_data, @graph_height_pdf, @y_labels)
      expected = [10 * Math.log10(5), 10 * Math.log10(900), 10 * Math.log10(800_000)]
      expect(log_y_pdf_data_collector.collect).to eq(expected)
    end

    it "it returns nil when a value is nil" do
      input_data = [["Jan 11", 5], ["Feb 11", nil], ["Mar 11", 800_000]]
      log_y_pdf_data_collector = LogYPdfDataCollector.new(input_data, @graph_height_pdf, @y_labels)
      expected = [10 * Math.log10(5), nil, 10 * Math.log10(800_000)]
      expect(log_y_pdf_data_collector.collect).to eq(expected)
    end
  end
end
