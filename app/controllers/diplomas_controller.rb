class DiplomasController < ApplicationController
  def index
    @diplomas = Diploma.all
  end

  def show
    build_meta_tag(:id)
    @diploma = Diploma.find(params[:id])
    
    respond_to do |format|
      format.html { render "show" }
      format.png do
        dom = render_to_string(template: 'diplomas/_diploma.png', layout: 'layouts/imgkit')
        p dom
        kit = IMGKit.new(dom, width: 600, height: 600)
        if params[:download]
          file_path = "#{Rails.root}/public/#{params[:id]}.png"
          file = kit.to_file(file_path)
          send_file(file_path, :filename => "완주기록_#{params[:id]}.png", :type => "image/png",:disposition => 'attachment',:streaming=> 'true')
        else
          send_data(kit.to_img(:png), :type => "image/png", :disposition => 'inline')
        end
      end
    end
  end

  def search_form
    @diplomas = Diploma.all
  end

  def search
    diploma = Diploma.find_by_name params['name']
    if diploma.present?
      redirect_to diploma_path(diploma)
    else
      redirect_to root_path, alert: '이름을 찾을 수 없습니다.'
    end
  end

  private

  def build_meta_tag(id)
    set_meta_tags og: { description: '경기 결과', image: diploma_path(format: :png), url: diploma_path }
  end
end
