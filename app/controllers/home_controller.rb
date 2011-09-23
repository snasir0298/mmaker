require 'nokogiri'
class HomeController < ApplicationController  
  def index
    fetch_sounds
    fetch_images
    background_sound
  end

  def fetch_sounds
    doc = Nokogiri::XML(open("#{RAILS_ROOT}/public/sounds.xml"))
    sounds = doc.xpath('//sounds/sound').map do |i|
      {'id' => i.xpath('id'), 'url' => i.xpath('url'), 'duration' => i.xpath('duration')}
    end

    @sounds = []
    count = 0
    sounds.each do|s|
      @sounds[count] = {"url" => s["url"].inner_text, "id" => s["id"].inner_text, "duration" => s["duration"].inner_text}.to_json
      count += 1
    end
#    @sounds[1] = {"url"=>'',"duration"=>'3000'}.to_json
#    @sounds[1] = {"id"=>'0',"url"=>"media/MediaMaker_Welcome.mp3","duration"=>'12500'}.to_json
#    @sounds[2] = {"id"=>'1',"url"=>"media/MediaMaker_Aquarius.mp3","duration"=>'14000'}.to_json
#    @sounds[3] = {"id"=>'2',"url"=>"media/MediaMaker_Love.mp3","duration"=>'2000'}.to_json
#    @sounds[4] = {"id"=>'3',"url"=>"media/MediaMaker_Venus-in-Leo.mp3","duration"=>'6000'}.to_json
#    @sounds[5] = {"id"=>'4',"url"=>"media/MediaMaker_Get-Ready.mp3","duration"=>'7000'}.to_json
  end

  def fetch_images
    @images = []
    @imgs = []

    doc = Nokogiri::XML(open("#{RAILS_ROOT}/public/images.xml"))
    images = doc.xpath('//images/image').map do |i|
      {'src' => i.xpath('src'), 'alt' => i.xpath('alt'), 'from' => i.xpath('from'), 'to' => i.xpath('to'), 'time' => i.xpath('time'), 'sound' => i.xpath('sound_id')}
    end

    count = 0
    images.each do|s|
      @imgs[count] = {"src" => s["src"].inner_text, "alt" => s["alt"].inner_text, "from" => s["from"].inner_text, "to" => s["to"].inner_text, "time" => s["time"].inner_text, "sound" => s["sound"].inner_text}
      @images[count] = {"src" => s["src"].inner_text, "alt" => s["alt"].inner_text, "from" => s["from"].inner_text, "to" => s["to"].inner_text, "time" => s["time"].inner_text, "sound" => s["sound"].inner_text}.to_json
      count += 1
    end
    return @images

#    @images[0]  = {"src" => 'images/Astrology-Logo.jpg',"alt" => 'Astrology.com',"from" => '100% 100% 1x',"to" => '100% 100% 1x',"time" => '.1' }.to_json
#    @images[1]  = {"src" => 'images/Whitish-Rectangle.jpg', "alt" => 'Personal Profile', "from" => '100% 100% 1x',"to" => '100% 100% 1x',"time" => '.1'}.to_json
#    @images[2]  = {"src" => 'images/Title.jpg', "alt" => '', "from" => '100% 100% 1x',"to" => '100% 100% 1x',"time" => '4'}.to_json
#    @images[3]  = {"src" => 'images/Black-Rectangle.jpg', "alt" => '', "from" => '100% 100% 1x',"to" => '100% 100% 1x',"time" => '.1'}.to_json
#    @images[4]  = {"src" => 'images/Houses.jpg', "alt" => 'Houses', "from" => '100% 80% 1x',"to" => '100% 0% 1.7x',"time" => '4'}.to_json
#    @images[5]  = {"src" => 'images/Constellations.jpg', "alt" => 'Constellations', "from" => 'top left 1.3x',"to" => 'bottom right 1.5x',"time" => '2'}.to_json
#    @images[6]  = {"src" => 'images/Aquarius.jpg', "alt" => 'Aquarius', "from" => '100% 80% 1.5x',"to" => '80% 0% 1.1x',"time" => '8'}.to_json
#    @images[7]  = {"src" => 'images/Persuasive-Essay-Ideas.jpg', "alt" => 'Ideas', "from" => '100% 80% 1.2x',"to" => '100% 20% 1.5x',"time" => '4'}.to_json
#    @images[8]  = {"src" => 'images/Leo.jpg', "alt" => 'Leo', "from" => '100% 0% 1.1x',"to" => '30% 50% 1.5x',"time" => '4'}.to_json
#    @images[9]  = {"src" => 'images/Titanic_Movie_Leo_Kate_Kiss.jpg', "alt" => 'Kiss', "from" => '100% 70% 1.5x',"to" => '80% 20% 1.2x',"time" => '2'}.to_json
#    @images[10] = {"src" => 'images/Houses.jpg', "alt" => 'Houses', "from" => '100% 80% 1.5x',"to" => '100% 0% 1.9x',"time" => '9'}.to_json
#    @images[11] = {"src" => 'images/Constellations.jpg', "alt" => 'Constellations', "from" => 'top left 1.3x',"to" => 'bottom right 1.5x',"time" => '2'}.to_json
  end

  def background_sound
    @bg_sound = []
    doc = Nokogiri::XML(open("#{RAILS_ROOT}/public/bg_sounds.xml"))
    sounds = doc.xpath('//sounds/sound').map do |i|
      {'id' => i.xpath('id'), 'url' => i.xpath('url')}
    end

    count = 0
    sounds.each do|s|
      @bg_sound[count] = {"id" => s["id"].inner_text, "url" => s["url"].inner_text}.to_json
      count += 1
    end
#    @bg_sound[0] = {"id" => 'background', "url" => 'media/Red-Handed-Instrumental.mp3'}.to_json
  end

end