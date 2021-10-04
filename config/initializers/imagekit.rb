IMGKit.configure do |config|
  #config.wkhtmltoimage = '/usr/bin/wkhtmltoimage'
  config.default_options = {
    quality: 70,
    encoding: 'UTF-8'
    #binmode: true
  }
 config.default_format = :png
end
