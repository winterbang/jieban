require 'open-uri'
namespace :fetch do
  desc "抓取旅程"
  task topic: :environment do
    url = "http://yueban.com/s/2016-2/create"
    page = Nokogiri::HTML(open(url))
    topics = page.css('.topic-list .topic')
    topics.each do |topic|
      p '============start==============='

      profile_url = "http://yueban.com" + topic.css('a.avatar')[0]['href']
      user_page = Nokogiri::HTML(open(profile_url))
      name = user_page.css('.avatar-big img')[0]['alt']
      img_url = user_page.css('.avatar-big img')[0]['src']
      p name, img_url
      date, departure = topic.css('.title').text[1..-2].split(' ')
      p "出发日期：#{date}"
      p "出发地：#{departure[0..-3]}"
      destinations = topic.css('.step').map {|step| step.text}
      p "目的地：#{destinations}"
      tags = topic.css('.topic-tag span').map {|tag| tag.text}
      tags_h = tag_classify(tags)
      p "旅程天数：#{tags_h[:dates]}"
      p "预算：#{tags_h[:budget]}"
      p "QQ：#{tags_h[:qq]}"
      intro = topic.css('.section-content').text.squish!
      p "intro：#{intro}"
      p '============ end ==============='
    end
  end

  def tag_classify(tags)
    tags_h = {}
    tags.each do |tag|
      regs = /\d+/
      d = tag.scan(regs)[0]
      key = :budget if tag.include?('预算')
      key = :dates  if tag.include?('旅程')
      key = :qq     if tag.include?('QQ')
      tags_h[key] = d
    end
    tags_h
  end
end
