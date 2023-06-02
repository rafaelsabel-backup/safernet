class Link < ApplicationRecord
  scope :by_domain, -> (domain) { where('domain LIKE ?', "%#{domain}%") if domain.present? }
  scope :by_tld, -> (tld) { where('tld LIKE ?', "%#{tld}%") if tld.present? }
  scope :by_cctld, -> (cctld) { where('cctld LIKE ?', "%#{cctld}%") if cctld.present? }

  validates :url, length: { maximum: 5000 }, presence: true
  validates :domain, length: { maximum: 255 }, presence: true
  validates :tld, length: { maximum: 255 }
  validates :cctld, length: { maximum: 255 }
  validates :path, length: { maximum: 5000 }
  validates :query, length: { maximum: 5000 }
  validates :fragment, length: { maximum: 255 }
end
