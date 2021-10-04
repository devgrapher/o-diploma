class ApplicationController < ActionController::Base
  before_action :build_meta_tags

  def build_meta_tags
    set_meta_tags title: '2021 플레이오그라운드', og: { title: '플레이오그라운', description: '경기 결과', image: 'localhost:3000/public/bg.png' }
  end
end
