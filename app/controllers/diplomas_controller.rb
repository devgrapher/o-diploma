class DiplomasController < ApplicationController
  def index
    p 'test'
  end

  def show
    @diploma = Diploma.find(params[:id])
    
    respond_to do |format|
      format.html { render "show" }
      format.png do
        dom = render_to_string(template: 'diplomas/_diploma.png', layout: 'layouts/imgkit')
        p dom
        kit = IMGKit.new(dom, width: 600, height: 600)
        send_data(kit.to_img(:png), :type => "image/png", :disposition => 'inline')
        #file = kit.to_file("#{Rails.root}/public/#{params[:id]}.png")
        #send_file("#{Rails.root}/public/#{params[:id]}.png", :filename => "screenshot.png", :type => "image/png",:disposition => 'attachment',:streaming=> 'true')
      end
    end
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
