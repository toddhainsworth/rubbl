require 'spec_helper'

RSpec.describe Rubbl::Workspace do
  describe '.all' do
    context 'when there are workspaces available' do
      it 'returns a list of Workspace objects' do
        VCR.use_cassette('workspace_all_success') do
          workspaces = Rubbl::Workspace.all(@api_key)
          expect(workspaces.length).not_to eq(0)
          expect(workspaces.first).not_to be_nil
        end
      end
    end

    context 'when there\'s no workspaces available' do
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

  describe '#users' do
    let(:workspace) { Rubbl::Workspace.new({ 'id' => 123 }, @api_key) }

    # because the user has done exactly what we've done in our let :)
    context 'when the workspace does not exist' do
      it 'raises an error' do
        VCR.use_cassette('workspace_users_w_not_exist') do
          expect {
              workspace.users
          }.to raise_error(StandardError).with_message(/Workspace does not exist/)
        end
      end
    end

    context 'when the workspace has no users' do
      it 'does not raise an error' do
        VCR.use_cassette('workspace_users_success') do
          expect {
              workspace.users
          }.not_to raise_error(StandardError)
        end
      end

      it 'returns an empty array' do
        VCR.use_cassette('workspace_users_success_empty') do
          users = workspace.users
          expect(users).to eq([])
        end
      end
    end

    context 'when the workspace has users' do
      it 'returns an array of users' do
        VCR.use_cassette('workspace_users_success') do
          users = workspace.users
          expect(users.first).not_to be_nil
        end
      end
    end
  end
end
