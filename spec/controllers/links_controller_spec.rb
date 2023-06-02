require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'GET #index' do
    context 'assigns links filtered' do
      let!(:link1) { create(:link, domain: 'example.com', tld: 'com', cctld: 'br') }
      let!(:link2) { create(:link, domain: 'test.com', tld: 'com', cctld: 'us') }
      let!(:link3) { create(:link, domain: 'example.net', tld: 'net', cctld: 'us') }

      it 'by domain, TLD, and ccTLD' do
        get :index, params: { domain: 'example', tld: 'com', cctld: 'br' }

        expect(assigns(:links)).to eq([link1])
      end

      it 'returns empty array filtered by domain, TLD, and ccTLD' do
        get :index, params: { domain: 'domain', tld: 'tld', cctld: 'cctld' }

        expect(assigns(:links)).to eq([])
      end
    end

    context 'assigns all links' do
      let!(:link1) { create(:link, domain: 'example.com', tld: 'com', cctld: 'br') }
      let!(:link2) { create(:link, domain: 'test.com', tld: 'com', cctld: 'us') }
      let!(:link3) { create(:link, domain: 'example.net', tld: 'net', cctld: 'us') }

      it do
        get :index

        expect(assigns(:links)).to eq([link1, link2, link3])
      end
    end

    it 'paginates links with 50 links per page' do
      create_list(:link, 60)

      get :index

      expect(assigns(:links)).to be_a(ActiveRecord::Relation)
      expect(assigns(:links).current_page).to eq(1)
      expect(assigns(:links).limit_value).to eq(50)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end
end
