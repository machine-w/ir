TruncateHtml.configure do |config|
  config.length        = 500
  config.omission      = '......'
  config.break_token   = '<!-- truncate -->'
end