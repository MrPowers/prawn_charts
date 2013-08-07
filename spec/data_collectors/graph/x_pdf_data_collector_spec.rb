require 'spec_helper'

module PrawnCharts
  describe XPdfDataCollector do
    before do
      input_data = [["Jan 11", 5], ["Feb 11", 2], ["Mar 11", 12]]
      graph_width_pdf = 160
      @x_pdf_data_collector = XPdfDataCollector.new(input_data, graph_width_pdf)
    end

    context "#pdf_points_per_unit" do
      it "returns number of pdf points per unit on x axis" do
        expect(@x_pdf_data_collector.pdf_points_per_unit).to eq(80.0)
      end
    end

    context "#collect" do
      it "returns an array of x pdf points" do
        expect(@x_pdf_data_collector.collect).to eq([0, 80, 160])
      end
    end
  end
end
