# 6) setIntervalに関数渡す
require 'js'
require "cgi"

def console_log(message)
  puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')}: #{message}"
end

def output_html(message)
  output = JS.global[:document].getElementById("output")
  output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML(message)}<br>"
end

def document
  @document ||= JS.global[:document]
end

def execute
  counter = 0
  render = ->() {
    # clearIntervalの仕方がわからん
    return if counter >= 100

    console_log "loop #{counter}"
    output_html "loop #{counter}"
    counter += 1
  }

  # JavascriptのsetIntervalにrenderのprocを渡す
  JS.global.call(:setInterval, JS.try_convert(render), 10)
end

button = document.getElementById('executeButton')

button.addEventListener 'click' do |_e|
  ruby_code = document.getElementById('rubyCode')[:value].to_s
  execute_ruby_code(ruby_code)
end
