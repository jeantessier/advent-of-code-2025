require './constraint'
require './constraint_set'

describe ConstraintSet do
  subject(:constraint_set) { ConstraintSet.new }

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

  describe :restrict_variables do
    subject { constraint_set.restrict_variables }

    before do
      constraint_set << a_less_restritive_constraint_for_variable_0
      constraint_set << another_less_restritive_constraint_for_variable_0
      constraint_set << a_more_restritive_constraint_for_variable_0
      constraint_set << a_constraint_unrelated_to_variable_0
    end

    context "when one contraint has a lower maximum than the others" do
      let(:a_less_restritive_constraint_for_variable_0) { Constraint.new(variables: [0..10, nil], total: 10) }
      let(:another_less_restritive_constraint_for_variable_0) { Constraint.new(variables: [0..10, 0..10], total: 10) }
      let(:a_more_restritive_constraint_for_variable_0) { Constraint.new(variables: [0..5, nil], total: 5) }
      let(:a_constraint_unrelated_to_variable_0) { Constraint.new(variables: [nil, 0..10], total: 10) }

      it "should restrict that variable in all constraints by the most restrictive constraint" do
        expect(subject.constraints[0].variables[0]).to eq 0..5
        expect(subject.constraints[1].variables[0]).to eq 0..5
        expect(subject.constraints[2].variables[0]).to eq 0..5
        expect(subject.constraints[3].variables[0]).to be_nil

        expect(subject.constraints[0].variables[1]).to be_nil
        expect(subject.constraints[1].variables[1]).to eq 0..10
        expect(subject.constraints[2].variables[1]).to be_nil
        expect(subject.constraints[3].variables[1]).to eq 0..10
      end
    end

    context "when one contraint has a higher minimum than the others" do
      let(:a_less_restritive_constraint_for_variable_0) { Constraint.new(variables: [0..10, nil], total: 10) }
      let(:another_less_restritive_constraint_for_variable_0) { Constraint.new(variables: [0..10, 0..10], total: 10) }
      let(:a_more_restritive_constraint_for_variable_0) { Constraint.new(variables: [5..10, nil], total: 5) }
      let(:a_constraint_unrelated_to_variable_0) { Constraint.new(variables: [nil, 0..10], total: 10) }

      it "should restrict that variable in all constraints by the most restrictive constraint" do
        expect(subject.constraints[0].variables[0]).to eq 5..10
        expect(subject.constraints[1].variables[0]).to eq 5..10
        expect(subject.constraints[2].variables[0]).to eq 5..10
        expect(subject.constraints[3].variables[0]).to be_nil

        expect(subject.constraints[0].variables[1]).to be_nil
        expect(subject.constraints[1].variables[1]).to eq 0..10
        expect(subject.constraints[2].variables[1]).to be_nil
        expect(subject.constraints[3].variables[1]).to eq 0..10
      end
    end
  end

  describe :constraints_by_number_of_variables do
    subject { constraint_set.constraints_by_number_of_variables }

    let(:a_constraint_with_1_variable) { Constraint.new(variables: [0..10, nil], total: 10) }
    let(:a_constraint_with_2_variables) { Constraint.new(variables: [0..10, 0..10], total: 10) }
    let(:another_constraint_with_1_variable) { Constraint.new(variables: [5..10, nil], total: 5) }
    let(:another_constraint_with_1_variable_but_a_different_variable) { Constraint.new(variables: [nil, 0..10], total: 10) }

    before do
      constraint_set << a_constraint_with_1_variable
      constraint_set << a_constraint_with_2_variables
      constraint_set << another_constraint_with_1_variable
      constraint_set << another_constraint_with_1_variable_but_a_different_variable
    end

    it "groups constraints based on their number of variables" do
      expect(subject[1]).to contain_exactly(a_constraint_with_1_variable, another_constraint_with_1_variable, another_constraint_with_1_variable_but_a_different_variable)
      expect(subject[2]).to contain_exactly(a_constraint_with_2_variables)
    end
  end

  describe :variables_by_impact do
    subject { constraint_set.variables_by_impact }

    let(:a_constraint_with_variable_0_only) { Constraint.new(variables: [0..10, nil], total: 10) }
    let(:a_constraint_with_variable_0_and_variable_1) { Constraint.new(variables: [0..10, 0..10], total: 10) }
    let(:another_constraint_with_variable_0_only) { Constraint.new(variables: [5..10, nil], total: 5) }
    let(:a_constraint_with_variable_1_only) { Constraint.new(variables: [nil, 0..10], total: 10) }

    before do
      constraint_set << a_constraint_with_variable_0_only
      constraint_set << a_constraint_with_variable_0_and_variable_1
      constraint_set << another_constraint_with_variable_0_only
      constraint_set << a_constraint_with_variable_1_only
    end

    it "groups variables based on one many constraints they impact" do
      expect(subject[0]).to eq 3
      expect(subject[1]).to eq 2
    end
  end

  describe :variations do
    subject { constraint_set.variations }

    context "a 1-variable constraint leads to a single variation" do
      let(:a_1_variable_constraint) { Constraint.new(variables: [nil, 0..10, nil], total: 10) }
      let(:a_2_variables_constraint) { Constraint.new(variables: [0..10, nil, 0..10], total: 10) }

      before do
        constraint_set << a_1_variable_constraint
        constraint_set << a_2_variables_constraint
      end

      it { is_expected.to eq [[nil, 10..10, nil]] }
    end

    context "a 2-variable constraint leads to variations on its most impactful variable" do
      let(:a_first_constraint) { Constraint.new(variables: [0..3, nil, 0..1, nil, nil], total: 2) }
      let(:a_second_constraint) { Constraint.new(variables: [0..3, nil, 0..1, 5..10, 0..10], total: 10) }
      let(:a_third_constraint) { Constraint.new(variables: [0..3, 0..10, 0..1, 5..10, 0..10], total: 10) }
      let(:a_fourth_constraint) { Constraint.new(variables: [0..3, 0..10, nil, nil, 0..10], total: 10) }

      before do
        constraint_set << a_first_constraint
        constraint_set << a_second_constraint
        constraint_set << a_third_constraint
        constraint_set << a_fourth_constraint
      end

      it { is_expected.to eq (0..3).map { |i| [i..i, nil, nil, nil, nil] } }
    end
  end

  describe :+ do
    subject { constraint_set + variation }

    let(:a_first_constraint) { Constraint.new(variables: [0..3, nil, 0..1, nil, nil], total: 2) }
    let(:a_second_constraint) { Constraint.new(variables: [0..3, nil, 0..1, 5..10, 0..10], total: 10) }
    let(:a_third_constraint) { Constraint.new(variables: [0..3, 0..10, 0..1, 5..10, 0..10], total: 10) }
    let(:a_fourth_constraint) { Constraint.new(variables: [0..3, 0..10, nil, nil, 0..10], total: 10) }

    before do
      constraint_set << a_first_constraint
      constraint_set << a_second_constraint
      constraint_set << a_third_constraint
      constraint_set << a_fourth_constraint
    end

    let(:variation) { [2..2, nil, nil, nil, nil] }

    it "applies variation to all constraints" do
      expect(subject.constraints[0].variables).to eq [2..2, nil, 0..1, nil, nil]
      expect(subject.constraints[1].variables).to eq [2..2, nil, 0..1, 5..10, 0..10]
      expect(subject.constraints[2].variables).to eq [2..2, 0..10, 0..1, 5..10, 0..10]
      expect(subject.constraints[3].variables).to eq [2..2, 0..10, nil, nil, 0..10]
    end
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
