require './constraint'
require './constraint_set'

describe ConstraintSet do
  subject(:constraint_set) { described_class.new }

  let(:valid_constraint) { Constraint.new(variables: [0..5, nil, 0..5, nil], total: 5) }
  let(:invalid_constraint) { Constraint.new(variables: [nil, nil, 0..5, nil], total: 10) }

  it "accepts constraints" do
    constraint_set << valid_constraint
    constraint_set << invalid_constraint
    expect(constraint_set.constraints.size).to eq 2
  end

  it "de-dupes constraints" do
    3.times { constraint_set << valid_constraint }
    expect(constraint_set.constraints.size).to eq 1
  end

  it "is valid if all constraints are valid" do
    constraint_set << valid_constraint
    expect(constraint_set.valid?).to be_truthy
  end

  it "is invalid if any constraint is invalid" do
    constraint_set << valid_constraint
    constraint_set << invalid_constraint
    expect(constraint_set.valid?).to be_falsey
  end

  context "complex set" do
    before do
      constraint_set << Constraint.new(variables: [0..5, 0..5, 0..5, nil], total: 10)
      constraint_set << Constraint.new(variables: [0..5, nil, 0..5, 0..11], total: 11)
      constraint_set << Constraint.new(variables: [0..5, nil, 0..5, 0..11], total: 11)
      constraint_set << Constraint.new(variables: [0..5, 0..5, nil, nil], total: 5)
      constraint_set << Constraint.new(variables: [0..5, 0..5, 0..5, nil], total: 10)
      constraint_set << Constraint.new(variables: [nil, nil, 0..5, nil], total: 5)
    end

    it "valid?" do
      expect(constraint_set.valid?).to be_truthy
    end

    it "num_pos" do
      expect(constraint_set.num_pos).to eq 20_155_392
    end

    it "size" do
      expect(constraint_set.constraints.size).to eq 4
    end

    it "impacts" do
      expect(constraint_set.impacts).to eq [3, 2, 3, 1]
    end

    context "creates a new set based on a variation" do
      let(:new_constraint_set) { constraint_set + [nil, nil, 5..5, nil] }

      it "valid?" do
        expect(new_constraint_set.valid?).to be_truthy
      end

      it "num_pos" do
        expect(new_constraint_set.num_pos).to eq 93_312
      end

      it "size" do
        expect(new_constraint_set.constraints.size).to eq 3
      end
    end
  end
end
