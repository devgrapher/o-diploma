class ApplicationController < ActionController::Base
  before_action :build_meta_tags

  def build_meta_tags
    set_meta_tags description: "기록증 확인", og: { title: '오리엔티어링', site_name: '오리엔티어링', description: '기록증 확인', image: 'https://odiploma.s3.ap-northeast-2.amazonaws.com/main.jpeg?v1' }
  end
end
