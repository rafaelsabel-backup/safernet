class LinksController < ApplicationController
  def index
    @links = Link
              .by_domain(params[:domain])
              .by_tld(params[:tld])
              .by_cctld(params[:cctld])
              .page(params[:page]).per(50)
  end
end
