# 6) setIntervalに関数渡す
require 'js'
require "cgi"

def console_log(message)
  puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')}: #{message}"
end

def document
  @document ||= JS.global[:document]
end

def clear_html
  output = document.getElementById("output")
  output[:innerHTML] = ""
end

# お見合い成立 6.3%
# 仮交際成立 34.9%
# 交際成立 9.6%
# 結婚成立 59.8%
def output_html
  output = document.getElementById("output")

  if rand(100) <= 6.3
    output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML("[お見合い成立]")}"
  else
    output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML("[お見合い不成立]")}<br>"
    return
  end

  if rand(100) <= 34.0
    output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML("[仮交際成立]")}"
  else
    output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML("[仮交際不成立]")}<br>"
    return
  end

  if rand(100) <= 9.6
    output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML("[真剣交際成立]")}"
  else
    output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML("[仮交際不成立]")}<br>"
    return
  end

  if rand(100) <= 59.8
    output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML("[成婚成立]")}<br>"
  else
    output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML("[成婚不成立]")}<br>"
  end

end

def execute
  clear_html()
  counter = 1
  render = ->() {
    # clearIntervalの仕方がわからん
    return if counter > 101

    console_log "loop #{counter}"
    output_html
    counter += 1
  }

  # JavascriptのsetIntervalにrenderのprocを渡す
  JS.global.call(:setInterval, JS.try_convert(render), 10)
end

button = document.getElementById('executeButton')

button.addEventListener 'click' do |_e|
  execute()
end
