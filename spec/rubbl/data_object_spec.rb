require 'spec_helper'

RSpec.describe Rubbl::DataObject do
  describe 'method_missing' do
    context 'when the attribute exists' do
      let(:obj) { Rubbl::DataObject.new(foo: 'bar') }
      
      it 'returns the value of the attribute' do
        expect(obj.foo).to eq('bar')
      end
    end

    context 'when the attribute does not exist' do
      let(:obj) { Rubbl::DataObject.new }
      
      context 'when a method exists' do
        it 'does not raise a NoMethodError' do
          ## FIXME: Rspec recommends not using raise checks as it can lead the false positives
          ## Do we wanna just `RSpec::Expectations.configuration.on_potential_false_positives = :nothing` ???
          expect {
            obj.to_s
          }.not_to raise_error(NoMethodError)
        end
      end

      context 'when a method does not exist' do
        it 'raise a no method error' do
          expect {
            obj.foo
          }.to raise_error(NoMethodError)
        end
      end
    end
  end
end
