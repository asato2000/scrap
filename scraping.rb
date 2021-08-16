require "nokogiri"

def get_from(url)
  Net::HTTP.get(URI(url))
end

def write_file(path, text)
  File.open(path, 'w') { |file| file.write(text) }
end



html = File.open('pitnews.html', 'r') {|f| f.read }
doc = Nokogiri::HTML.parse(html, nil, 'utf-8')

section = doc.xpath('/html/body/main/section[2]').first

contents = {category: nil, news: []}
contents[:category] = section.xpath('./h6').first.text
section.xpath('./div/div').each do |node|
  title = node.xpath('./p/strong/a').first.text
  url = node.xpath('./p/strong/a').first['href']

  # === ここから追加および編集
  news = {title: title, url: url}
  contents[:news] << news
  # === ここまで
end
pp contents
