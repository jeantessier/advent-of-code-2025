require './constraint'

describe Constraint do
  [
    [ 'a partial constraint', [0..5, 0..5, 0..5, nil], 10, 3, 216, 0..15, true ],
    [ 'an empty constraint', [nil, nil, nil, nil], 0, 0, 0, 0..0, true ],
    [ 'a broken constraint', [nil, nil, 4..4, nil], 10, 0, 1, 4..4, false ],
    [ 'a broken empty constraint', [nil, nil, nil, nil], 10, 0, 0, 0..0, false ],
  ].each do |label, variables, total, expected_num_vars, expected_num_pos, expected_range, expected_valid|
    describe "for #{label}" do
      let(:constraint) { Constraint.new(variables: variables, total: total) }

      context "num_vars" do
        subject { constraint.num_vars }
        it { is_expected.to eq expected_num_vars }
      end

      context "num_pos" do
        subject { constraint.num_pos }
        it { is_expected.to eq expected_num_pos }
      end

      context "range" do
        subject { constraint.range }
        it { is_expected.to eq expected_range }
      end

      context "valid?" do
        subject { constraint.valid? }
        it { is_expected.to eq expected_valid }
      end
    end
  end

  describe :+ do
    [
      ['a relevant variation', [0..5, nil, 0..5, nil], 5, [4..4, nil, nil, nil], [4..4, nil, 0..5, nil], 5],
      ['an irrelevant variation', [0..5, nil, 0..5, nil], 5, [nil, 4..4, nil, nil], [0..5, nil, 0..5, nil], 5],
    ].each do |label, initial_variables, initial_total, variation, expected_variables, expected_total|
      describe "when adding #{label}" do
        let(:constraint) { Constraint.new(variables: initial_variables, total: initial_total) }
        let(:resulting_constraint) { constraint + variation }

        describe "variables #{initial_variables} + #{variation}" do
          subject { resulting_constraint.variables }
          it { is_expected.to eq expected_variables }
        end

        describe "total" do
          subject { resulting_constraint.total }
          it { is_expected.to eq expected_total }
        end
      end
    end
  end

  describe :== do
    let(:constraint) { Constraint.new(variables: [0..5, nil, 0..5, nil], total: 5) }

    subject { constraint == other_constraint }

    [
      ['an identical constraint', [0..5, nil, 0..5, nil], 5, true],
      ['different variables', [nil, 4..4, nil, nil], 5, false],
      ['different total', [0..5, nil, 0..5, nil], 10, false],
    ].each do |label, variables, total, expected_result|
      describe "when comparing to #{label}" do
        let(:other_constraint) { Constraint.new(variables: variables, total: total) }
        it { is_expected.to eq expected_result }
      end
    end
  end

  describe :running_total do
    let(:constraint) { Constraint.new(variables: variables, total: 5) }

    subject { constraint.running_total }

    [
      ['no variable with a determined value', [0..5, nil, 0..5, nil], 0],
      ['one variable with a determined value', [nil, 4..4, nil, nil], 4],
      ['multiple variables with determined values', [nil, 4..4, 0..5, 1..1], 5],
    ].each do |label, initial_variables, expected_result|
      describe "with #{label}" do
        let(:variables) { initial_variables }
        it { is_expected.to eq expected_result }
      end
    end
  end

  describe :constrain_variables! do
    let(:constraint) { Constraint.new(variables: variables, total: 5) }

    subject { constraint.constrain_variables!.variables }

    [
      ['no variable has a determined value', [0..5, nil, 0..5, nil], [0..5, nil, 0..5, nil]],
      ['one variable has a determined value', [4..4, nil, 0..5, nil], [4..4, nil, 0..1, nil]],
      ['multiple variables have determined values', [nil, 4..4, 0..5, 1..1], [nil, 4..4, 0..0, 1..1]],
    ].each do |label, initial_variables, expected_variables|
      describe "with #{label}" do
        let(:variables) { initial_variables }
        it { is_expected.to eq expected_variables }
      end
    end
  end

end
