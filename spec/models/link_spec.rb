require 'rails_helper'

RSpec.describe Link do
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:domain) }
  it { should validate_length_of(:url).is_at_most(5000) }
  it { should validate_length_of(:domain).is_at_most(255) }
  it { should validate_length_of(:tld).is_at_most(255) }
  it { should validate_length_of(:cctld).is_at_most(255) }
  it { should validate_length_of(:path).is_at_most(5000) }
  it { should validate_length_of(:query).is_at_most(5000) }
  it { should validate_length_of(:fragment).is_at_most(255) }

  describe 'scopes' do
    let!(:link1) { create(:link, url: 'http://example.com.br', domain: 'example.com', tld: 'com', cctld: 'br') }
    let!(:link2) { create(:link, url: 'www.test.com.us', domain: 'test.com', tld: 'com', cctld: 'us') }
    let!(:link3) { create(:link, url: 'example.net.us', domain: 'example.net', tld: 'net', cctld: 'us') }

    describe '.by_domain' do
      it 'returns links with matching domain' do
        expect(Link.by_domain('example')).to contain_exactly(link1, link3)
      end

      it 'returns empty array when no links match the domain' do
        expect(Link.by_domain('unknown.net')).to be_empty
      end
    end

    describe '.by_tld' do
      it 'returns links with matching TLD' do
        expect(Link.by_tld('com')).to contain_exactly(link1, link2)
      end

      it 'returns empty array when no links match the TLD' do
        expect(Link.by_tld('org')).to be_empty
      end
    end

    describe '.by_cctld' do
      it 'returns links with matching ccTLD' do
        expect(Link.by_cctld('us')).to contain_exactly(link2, link3)
      end

      it 'returns empty array when no links match the ccTLD' do
        expect(Link.by_cctld('uk')).to be_empty
      end
    end
  end
end
