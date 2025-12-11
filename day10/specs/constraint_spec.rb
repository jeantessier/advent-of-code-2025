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

    [
      ['an identical constraint', [0..5, nil, 0..5, nil], 5, true],
      ['different variables', [nil, 4..4, nil, nil], 5, false],
      ['different total', [0..5, nil, 0..5, nil], 10, false],
    ].each do |label, variables, total, expected_result|
      describe "when comparing to #{label}" do
        let(:other_constraint) { Constraint.new(variables: variables, total: total) }
        subject { constraint == other_constraint }
        it { is_expected.to eq expected_result }
      end
    end
  end

  describe "variations" do
    subject { constraint.variations }

    context "when constraint is not valid" do
      let(:constraint) { Constraint.new(variables: [nil, nil, 0..2, nil], total: 5) }

      it "generates no variations" do
        is_expected.to eq []
      end
    end

    context "1-variable constraint" do
      let(:constraint) { Constraint.new(variables: [nil, nil, 0..10, nil], total: 5) }

      it "generates a single variation for its total" do
        is_expected.to eq [[nil, nil, 5..5, nil]]
      end
    end

    context "2-variables constraint generates a single variation for its total" do
      let(:constraint) { Constraint.new(variables: [0..2, nil, 0..10, nil], total: 5) }

      it "generates variations on its variable with shortest range" do
        is_expected.to eq [
                          [0..0, nil, 5..5, nil],
                          [1..1, nil, 5..5, nil],
                          [2..2, nil, 5..5, nil],
                        ]
      end
    end
  end
end
