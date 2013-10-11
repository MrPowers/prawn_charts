require "spec_helper"

module PrawnCharts
  describe DataCollector do
    before do
      height = 60
      width = 80
      data = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}]
      @collector = DataCollector.new(height, width, data)
    end

    context "#x_labels_data" do
      it "returns an array of x data points and labels" do
        puts "hiiii"
        puts @collector.x_labels_data
      end
    end

    context "#graph_data_points" do
      it "returns an array of [x, y] pdf points" do
        expected = [[0, 17.65], [80, 60]]
        actual = @collector.graph_data_points
        actual.each_with_index do |xy_point, index|
          expect(xy_point[0]).to be_within(0.01).of expected[index][0]
          expect(xy_point[1]).to be_within(0.01).of expected[index][1]
        end
      end
    end

    context "#x_units" do
      it "returns the number of x units" do
        expect(@collector.send(:x_units)).to eq(1)
      end
    end

    context "#pdf_points_per_x_unit" do
      it "returns the number of pdf points per x unit" do
        expect(@collector.send(:pdf_points_per_x_unit)).to eq(80)
      end
    end

    context "#y_units" do
      it "returns the number of y units" do
        expect(@collector.send(:y_units)).to eq(17)
      end
    end

    context "#pdf_points_per_y_unit" do
      it "returns the number of pdf points per y unit" do
        expect(@collector.send(:pdf_points_per_y_unit)).to be_within(0.01).of(3.53)
      end
    end

    context "#x_pdf_data_points" do
      it "returns an array of x pdf points" do
        expected = [0, 80]
        actual = @collector.send(:x_pdf_data_points)
        actual.each_with_index do |actual_x_point, index|
          expect(actual_x_point).to be_within(0.01).of expected[index]
        end
      end
    end

    context "#y_pdf_data_points" do
      it "returns an array of y pdf points" do
        expected = [17.65, 60]
        actual = @collector.send(:y_pdf_data_points)
        actual.each_with_index do |actual_y_point, index|
          expect(actual_y_point).to be_within(0.01).of expected[index]
        end
      end
    end

  end
end
