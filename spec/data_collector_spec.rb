require "spec_helper"

module PrawnCharts
  describe DataCollector do

    data = [
      {x_label: "Apr-11", y: 10},
      {x_label: "May-11", y: nil},
      {x_label: "Jun-11", y: 30}
    ]
    input = { :width => 300, :height => 200, :data => data, :y_labels => [0, 10, 20] }
    let(:collector) { DataCollector.new(input) }

    context "#y_labels" do
      it "returns y_labels and associated y_pdf position" do
        collector.stub(:y_convert_to_pdf).with(0) { "zero" }
        collector.stub(:y_convert_to_pdf).with(10) { "ten" }
        collector.stub(:y_convert_to_pdf).with(20) { "twenty" }
        expected = [{:label=>"0", :y=>"zero"}, {:label=>"10", :y=>"ten"}, {:label=>"20", :y=>"twenty"}]
        expect(collector.y_labels).to eq expected
      end
    end

    context "#horizontal_lines" do
      it "returns starting and ending points for graph lines at y_labels" do
        collector.stub(:y_convert_to_pdf).with(0) { 10 }
        collector.stub(:y_convert_to_pdf).with(10) { 20 }
        collector.stub(:y_convert_to_pdf).with(20) { 30 }
        expected = [[[0, 10], [300, 10]], [[0, 20], [300, 20]], [[0, 30], [300, 30]]]
        expect(collector.horizontal_lines).to eq expected
      end
    end

    context "#data_points" do
      it "makes a DataPoint corresponding to every piece of data it is initialized with" do
        expect(collector.data_points).to have(3).things
      end
    end

    context "#graph_points" do
      it "returns all DataPoints with a y_pdf value that is truthy" do
        data_point_inputs = { x_units: 1, y_units: 2, x_pdf: 12, y_pdf: 16, x_label: "jan 12" }
        dp_1 = DataPoint.new(data_point_inputs)
        dp_2 = DataPoint.new(data_point_inputs)
        dp_3 = DataPoint.new(data_point_inputs.merge({ y_pdf: nil }))
        data_points = [dp_1, dp_2, dp_3]
        collector.stub(:data_points) { data_points }
        expect(collector.graph_points).to eq [dp_1, dp_2]
      end
    end

    context "#y_convert_to_pdf" do
      it "converts linear y_unit to y_pdf" do
        expect(collector.y_convert_to_pdf(8)).to eq 80
      end

      it "converts log y_unit to y_pdf" do
        input = { :width => 300, :height => 200, :data => [], :y_labels => [0, 10, 100], :scale => :log }
        collector = DataCollector.new(input)
        expect(collector.y_convert_to_pdf(12)).to be_within(0.1).of 107.9
      end
    end
  end
end
