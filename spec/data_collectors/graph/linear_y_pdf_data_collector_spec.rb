require 'spec_helper'

describe LinearYPdfDataCollector do
  before do
    input_data = [["Jan 11", 5], ["Feb 11", 2], ["Mar 11", 12]]
    graph_height_pdf = 160
    y_labels = [0, 4, 8, 12, 16]
    @linear_y_pdf_data_collector = LinearYPdfDataCollector.new(input_data, graph_height_pdf, y_labels)
  end

  context "#collect" do
    it "returns an array of y values in pdf points" do
      expected = [50, 20, 120]
      expect(@linear_y_pdf_data_collector.collect).to eq(expected)
    end
  end
end
