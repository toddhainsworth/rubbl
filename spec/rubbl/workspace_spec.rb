require 'spec_helper'

RSpec.describe Rubbl::Workspace do
  describe '.all' do
    it 'returns a list of Workspace objects' do
      VCR.use_cassette('workspace_all_success') do
        workspaces = Rubbl::Workspace.all(@api_key)
        expect(workspaces.length).not_to eq(0)
      end
    end
  end

  describe '.find' do
    context 'when a workspace with the specific ID exists' do
      it 'returns a corresponding Workspace object' do
      end
    end

    context 'when a workspace with the specific ID does not exist' do
      it 'returns nil' do
      end
    end
  end
end
