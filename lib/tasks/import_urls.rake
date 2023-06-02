require 'csv'

task import_urls: :environment do
  csv_file_paths = ['malicious_phish.csv', 'phishing_site_urls.csv']

  csv_file_paths.each do |csv_file_path|
    CSV.parse(File.read(csv_file_path), headers: true)[0..30000].each do |row|
      url = row[0]
      url = "http://#{url}" unless url[/:\/\//]

      begin
        uri = URI.parse(url)

        suffixes = PublicSuffix.parse(uri.host).tld.split('.')

        cctld = suffixes.pop if suffixes.last.size == 2
        tld = suffixes.join('.') if suffixes.present?

        Link.create!(
          url: row[0],
          domain: uri.host,
          tld: tld,
          cctld: cctld,
          path: uri.path.presence,
          query: uri.query,
          fragment: uri.fragment
        )
      rescue => e
        puts e
      end
    end
  end
end
