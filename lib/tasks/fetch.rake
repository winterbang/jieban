require 'open-uri'
require 'cgi'
namespace :fetch do
  desc "抓取旅程"
  task topic: :environment do
    url = "http://yueban.com/menu/"
    36.downto(0) do |i|
      page_url = i != 0 ? url + "#{20*i}" : url
      page     = Nokogiri::HTML(open(page_url))
      topics = page.css('.topic-list .topic').reverse
      p "============start #{i}/36==============="
      topics.each do |topic|
        profile_url = "http://yueban.com" + topic.css('a.avatar')[0]['href']
        user = get_user_profile_and_save(profile_url)
        date, departure = topic.css('.title').text[1..-2].split(' ')
        date = format_date(date)
        p "出发日期：#{date}"
        p "出发地：#{departure[0..-3]}"
        destinations = topic.css('.step').map {|step| step.text}
        p "目的地：#{destinations}"
        tags = topic.css('.topic-tag span').map {|tag| tag.text}
        tags_h = tag_classify(tags)
        p "旅程天数：#{tags_h[:dates]}"
        p "预算：#{tags_h[:budget]}"
        intro = topic.css('.section-content').text.squish!
        p "intro：#{intro}"
        travel_other = user.travel_others.find_or_create_by(date_of_departure: date, point_of_departure: departure[0..-3]) do |travel|
          travel.dates       = tags_h[:dates]
          travel.budget      = tags_h[:budget]
          travel.destination = destinations
          travel.intro       = intro
        end
      end
      p '============ end ==============='
    end
  end

  # 获取用户个人信息
  def get_user_profile_and_save(url)
    user_page = Nokogiri::HTML(open(url))
    name = user_page.at_css('.avatar-big img')['alt']
    img_url = user_page.at_css('.avatar-big img')['src']
    qq_node = user_page.at_css('.social-icons .qq')
    qq_url = qq_node['href'] if qq_node.present?
    weibo_node = user_page.at_css('.social-icons .weibo')
    weibo_url = weibo_node.present? ? weibo_node['href'] : nil
    douban_node = user_page.at_css('.social-icons .douban')
    douban_url = douban_node.present? ? douban_node['href'] : nil
    qq = qq_url.present? ? CGI.parse(URI.parse(qq_url).query)['uin'].first : nil
    p name, img_url
    UserOther.find_or_create_by(name: name) do |user|
      user.img_url = img_url
      user.qq      = qq
      user.weibo   = weibo_url
      user.douban  = douban_url
    end
  end

  def tag_classify(tags)
    tags_h = {}
    tags.each do |tag|
      regs = /\d+/
      d = tag.scan(regs)[0]
      key = :budget if tag.include?('预算')
      key = :dates  if tag.include?('旅程')
      tags_h[key] = d
    end
    tags_h
  end

  def format_date(date)
    regs = /\d+/
    d = date.scan(regs)
    d.unshift(DateTime.now.year).join('-').to_time
  end
end
