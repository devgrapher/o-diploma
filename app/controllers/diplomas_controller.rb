class DiplomasController < ApplicationController
  caches_action :show, expires_in: 1.hour, unless: -> { request.format.html? || params[:download] }

  def index
    @diplomas = Diploma.all
  end

  def show
    @diploma = Diploma.find(params[:id])
    build_meta_tag(@diploma)
    
    respond_to do |format|
      format.html { render "show" }
      format.png do
        dom = render_to_string(template: 'diplomas/_diploma.png', layout: 'layouts/imgkit')
        kit = IMGKit.new(dom, width: 600, height: 600)
        if params[:download]
          file_path = "#{Rails.root}/public/#{params[:id]}.png"
          file = kit.to_file(file_path)
          send_file(file_path, :filename => "완주증_#{@diploma.name}.png", :type => "image/png",:disposition => 'attachment',:streaming=> 'true')
        else
          send_data(kit.to_img(:png), :type => "image/png", :disposition => 'inline')
        end
      end
    end
  end

  def search_form
    @diplomas = Diploma.where.not(rank: nil).order('gameclass asc, rank asc')
    @diplomas += Diploma.where(rank: nil).order('gameclass asc')
  end

  def search
    diploma = Diploma.find_by_name params['name']
    if diploma.present?
      redirect_to diploma_path(diploma)
    else
      redirect_to root_path, alert: '이름을 찾을 수 없습니다.'
    end
  end

  def upload
    return if params.dig(:upload, :result).blank?

    csv_text = File.read(Rails.root.join(params[:upload][:result]))
    Diploma.load_csv csv_text, true

    redirect_to diplomas_path
  end

  private

  def build_meta_tag(diploma)
    set_meta_tags og: { image: diploma_path(diploma, format: :png), url: diploma_path(diploma) }
  end
end
