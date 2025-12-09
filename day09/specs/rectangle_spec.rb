require './red_tile'
require './rectangle'


describe Rectangle do
  context "segment intersects" do
    context "fat rectangle" do

      #                1    11     2    3
      #   0      7 9   3    89     5    0
      #  0             S1   S2          S3
      #                |    |           |
      #  2       /-----+----+------\    |
      #          |     |    |      |    |
      #          |     |    S2     |    |
      #          |     |           |    |
      #  6       \-----+-----S5----/    |
      #  7         S4  |     |          |
      #            |   |     |          |
      #  9         S4  S1    S5         S3
      # 10

      let(:rectanble) { Rectangle.new(RedTile.new(7, 2), RedTile.new(25, 6)) }

      subject { rectanble.intersects?(segment) }

      context "when segment crosses completely (S1)" do
        let(:segment) { Rectangle.new(RedTile.new(13, 0), RedTile.new(13, 9)) }
        it { is_expected.to be true }
      end

      context "when segment ends inside the rectangle (S2)" do
        let(:segment) { Rectangle.new(RedTile.new(18, 0), RedTile.new(18, 4)) }
        it { is_expected.to be true }
      end

      context "when segment is outside in the X direction (S3)" do
        let(:segment) { Rectangle.new(RedTile.new(30, 0), RedTile.new(30, 9)) }
        it { is_expected.to be false }
      end

      context "when segment is outside in the Y direction (S4)" do
        let(:segment) { Rectangle.new(RedTile.new(9, 7), RedTile.new(9, 9)) }
        it { is_expected.to be false }
      end

      context "when segment touches an edge (S5)" do
        let(:segment) { Rectangle.new(RedTile.new(19, 6), RedTile.new(19, 9)) }
        it { is_expected.to be false }
      end
    end

    context "skinny rectangle" do

      #                1    11     2    3
      #   0      7 9   3    89     5    0
      #  0             S1   S2          S3
      #                |    |           |
      #                |    |           |
      #                |    |           |
      #  4       /-----+----S2-----\    |
      #                |                |
      #  6             |     S5         |
      #  7         S4  |     |          |
      #            |   |     |          |
      #  9         S4  S1    S5         S3
      # 10

      let(:rectanble) { Rectangle.new(RedTile.new(7, 4), RedTile.new(25, 4)) }

      subject { rectanble.intersects?(segment) }

      context "when segment crosses completely (S1)" do
        let(:segment) { Rectangle.new(RedTile.new(13, 0), RedTile.new(13, 9)) }
        it { is_expected.to be true }
      end

      context "when segment touches an edge (S2)" do
        let(:segment) { Rectangle.new(RedTile.new(18, 0), RedTile.new(18, 4)) }
        it { is_expected.to be false }
      end

      context "when segment is outside in the X direction (S3)" do
        let(:segment) { Rectangle.new(RedTile.new(30, 0), RedTile.new(30, 9)) }
        it { is_expected.to be false }
      end

      context "when segment is outside in the Y direction (S4)" do
        let(:segment) { Rectangle.new(RedTile.new(9, 7), RedTile.new(9, 9)) }
        it { is_expected.to be false }
      end

      context "when segment is outside in the Y direction (S5)" do
        let(:segment) { Rectangle.new(RedTile.new(19, 6), RedTile.new(19, 9)) }
        it { is_expected.to be false }
      end
    end
  end
end
