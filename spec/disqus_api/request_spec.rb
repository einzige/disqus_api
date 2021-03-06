require 'spec_helper'

describe DisqusApi::Request do
  subject(:request) { described_class.new(api, namespace, action, arguments) }
  let(:api) { DisqusApi::Api.new(version, specifications) }
  let(:version) { '3.0' }
  let(:specifications) { {'users' => {'details' => 'get'}} }
  let(:namespace) { 'users' }
  let(:action) { 'details' }
  let(:arguments) { {} }

  its(:api) { should == api }
  its(:namespace) { should == namespace }
  its(:action) { should == action }
  its(:path) { should == 'users/details.json' }
  its(:type) { should == :get }
  its(:arguments) { should == arguments }
  its(:response) { should be_a(Hash) }
  its(:response) { should be_a(::DisqusApi::Response) }
  its(:response) { should have_key('code') }

  describe "#initialize" do
    context "invalid namespace" do
      let(:namespace) { 'foo' }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context "invalid action" do
      let(:action) { 'foo' }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe "#perform" do
    it 'sends request through API' do
      expect(request.perform['code']).to eq(0)
    end
  end

  describe ".perform" do
    it 'sends request through API' do
      expect(described_class.perform(api, namespace, action, arguments)['code']).to eq(0)
    end
  end
end
