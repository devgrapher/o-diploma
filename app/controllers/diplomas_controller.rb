class DiplomasController < ApplicationController
  def index
    p 'test'
  end

  def show
    @diploma = Diploma.find(params[:id])
  end

  def search
    diploma = Diploma.find_by_name params['name']
    if diploma.present?
      redirect_to diploma_path(diploma)
    else
      redirect_to root_path, alert: '이름을 찾을 수 없습니다.'
    end
  end
end
