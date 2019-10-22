require 'spec_helper'

RSpec.describe Rubbl::Workspace do
  describe '.all' do
    context 'when there are workspaces available' do
      it 'returns a list of Workspace objects' do
        VCR.use_cassette('workspace_all_success') do
          workspaces = Rubbl::Workspace.all(@api_key)
          expect(workspaces.length).not_to eq(0)
        end
      end
    end

    context 'when there\'s no workspaces availabje' do
      it 'returns nil' do
        VCR.use_cassette('workspace_all_fail') do
          workspaces = Rubbl::Workspace.all(@api_key)
          expect(workspaces).to be_nil
        end
      end
    end
  end

  describe '.find' do
    context 'when a workspace with the specific ID exists' do
      it 'returns a corresponding Workspace object' do
        VCR.use_cassette('workspace_single_success') do
          workspace = Rubbl::Workspace.find(1234567, @api_key)
          expect(workspace.id).to eq(1234567)
          expect(workspace.name).to eq("Personal Workspace")
        end
      end
    end

    context 'when a workspace with the specific ID does not exist' do
      it 'returns nil' do
        VCR.use_cassette('workspace_single_fail') do
          workspace = Rubbl::Workspace.find(1111111, @api_key)
          expect(workspace).to be_nil
        end
      end
    end
  end
end
