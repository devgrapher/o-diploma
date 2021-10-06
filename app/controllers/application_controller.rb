class ApplicationController < ActionController::Base
  before_action :build_meta_tags

  def build_meta_tags
    set_meta_tags og: { title: '플레이오그라운', description: '경기 결과', image: 'diploma.orienteering.co.kr/diploma.png' }
  end
end
