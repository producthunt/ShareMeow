require 'spec_helper'
require 'image_templates/shared_examples'

RSpec.describe ImageTemplates::HelloWorld do
  default_options = { 'message' => 'Hello, world' }

  describe '#to_html' do
    it 'renders the message' do
      expect(described_class.new(default_options).to_html).to include 'Hello, world'
    end
  end

  it_behaves_like 'an ImageTemplate', default_options
end
