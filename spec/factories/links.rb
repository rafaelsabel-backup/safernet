FactoryBot.define do
  factory :link do
    url { 'https://www.google.com.br/path?id=1#fragment' }
    domain { 'google.com.br' }
    tld { 'com' }
    cctld { 'br' }
    path { '/path' }
    query { 'id=1' }
    fragment { 'fragment' }
  end
end
