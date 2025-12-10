require './machine2'

describe Machine2 do
  let(:machine) { Machine2.new("[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}") }

  context "initialize" do
    it "buttons include (3)" do
      expect(machine.buttons).to include([0, 0, 0, 1])
    end

    it "buttons include (1,3)" do
      expect(machine.buttons).to include([0, 1, 0, 1])
    end

    it "buttons include (2)" do
      expect(machine.buttons).to include([0, 0, 1, 0])
    end

    it "buttons include (2,3)" do
      expect(machine.buttons).to include([0, 0, 1, 1])
    end

    it "buttons include (0,2)" do
      expect(machine.buttons).to include([1, 0, 1, 0])
    end

    it "buttons include (0,1)" do
      expect(machine.buttons).to include([1, 1, 0, 0])
    end

    it "joltages" do
      expect(machine.joltages).to eq([3, 5, 4, 7])
    end
  end

  context "crank_joltages" do
    it "handles empty joltages" do
      expect(machine.crank_joltages([0, 0, 0, 0])).to eq(Float::INFINITY)
    end

    it "handles button (3)" do
      expect(machine.crank_joltages([0, 0, 0, 1])).to eq(1)
    end

    it "handles deep button (3)" do
      pushes_so_far = 4
      expect(machine.crank_joltages([0, 0, 0, 1], pushes_so_far)).to eq(pushes_so_far + 1)
    end

    it "handles too deep button (3)" do
      pushes_so_far = 4
      max_pushes = 4
      expect(machine.crank_joltages([0, 0, 0, 1], pushes_so_far, max_pushes)).to eq(Float::INFINITY)
    end

    it "handles button (0,1)" do
      expect(machine.crank_joltages([1, 1, 0, 0])).to eq(1)
    end

    it "handles two buttons (3)" do
      expect(machine.crank_joltages([0, 0, 0, 2])).to eq(2)
    end

    it "handles no solution" do
      expect(machine.crank_joltages([1, 0, 0, 0])).to eq(Float::INFINITY)
    end

    it "gets the sample answer" do
      expect(machine.crank_joltages).to eq(10)
    end
  end

  context "make_change" do
    it "handles empty joltages" do
      expect(machine.make_change([0, 0, 0, 0])).to eq(0)
    end

    it "handles button (3)" do
      expect(machine.make_change([0, 0, 0, 1])).to eq(1)
    end

    it "handles button (0,1)" do
      expect(machine.make_change([1, 1, 0, 0])).to eq(1)
    end

    it "handles two buttons (3)" do
      expect(machine.make_change([0, 0, 0, 2])).to eq(2)
    end

    it "handles no solution" do
      expect(machine.make_change([1, 0, 0, 0])).to eq(nil)
    end

    it "gets the sample answer" do
      expect(machine.make_change).to eq(10)
    end
  end
end