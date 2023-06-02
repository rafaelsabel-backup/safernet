require 'rails_helper'
require 'rake'

RSpec.describe 'import_urls', type: :task do
  before(:all) do
    Rake.application.load_rakefile
    Rake::Task.define_task(:environment)
  end

  describe 'import_urls task' do
    let(:task) { Rake::Task['import_urls'] }

    it 'imports URLs from CSV files' do
      allow(File).to receive(:read).and_return("url,type\nexample.br,test\nexample.com,test")

      expect(Link).to receive(:create!).twice.with(
        url: 'example.br',
        domain: 'example.br',
        tld: nil,
        cctld: 'br',
        path: nil,
        query: nil,
        fragment: nil
      )

      expect(Link).to receive(:create!).twice.with(
        url: 'example.com',
        domain: 'example.com',
        tld: 'com',
        cctld: nil,
        path: nil,
        query: nil,
        fragment: nil
      )

      task.invoke
    end
  end
end
