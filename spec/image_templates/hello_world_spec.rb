require 'spec_helper'
require 'image_templates/shared_examples'

RSpec.describe ImageTemplates::HelloWorld do
  describe '#to_html' do
    it 'renders Hello, World' do
      expect(described_class.new.to_html).to include 'Hello, world'
    end
  end

  it_behaves_like 'an ImageTemplate'
end
