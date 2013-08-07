require "spec_helper"

describe PdfDataCollector do
  context "linear" do
    before do
      scale = :linear
      input_data = [["Jan 11", 5], ["Feb 11", 2], ["Mar 11", 12]]
      graph_width_pdf = 100
      graph_height_pdf = 120
      y_labels = [0, 3, 6, 9, 12]
      @linear_pdf_data_collector = PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels)
    end

    it "returns an array of pdf points where line should be plotted" do
      expected = [[0, 50], [50, 20], [100, 120]]
      expect(@linear_pdf_data_collector.collect).to eq(expected)
    end
  end

  context "log" do
    before do
      scale = :log
      input_data = [["Jan 11", 5], ["Feb 11", 900], ["Mar 11", 800_000]]
      graph_width_pdf = 200
      graph_height_pdf = 120
      y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000]
      @log_pdf_data_collector = PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels)
    end

    it "returns an array of pdf points where line should be plotted" do
      expected = [[0.0, Math.log10(5) * 20], [100.0, Math.log10(900) * 20], [200.0, Math.log10(800_000) * 20]]
      expect(@log_pdf_data_collector.collect).to eq(expected)
    end
  end

  context "invalid scale input" do
    it "raises an error unless scale is :linear or :log" do
      scale = :phattie
      input_data = [["Jan 11", 5], ["Feb 11", 900], ["Mar 11", 800_000]]
      graph_width_pdf = 200
      graph_height_pdf = 120
      y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000]
      log_pdf_data_collector = PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels)
      expect{log_pdf_data_collector.collect}.to raise_error(RuntimeError)
    end
  end
end
