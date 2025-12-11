require './machine2'

describe Machine2 do
  let(:machine) { Machine2.new("[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}") }

  it "has four constraints" do
    expect(machine.constraint_set.constraints.size).to eq 4
  end
end
