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

$status = { omiai_ok: 0, karikousai_ok: 0, sinkenkousai_ok: 0, seikon_ok: 0 }

# お見合い成立 6.3%
# 仮交際成立 34.9%
# 交際成立 9.6%
# 結婚成立 59.8%
def propose(counter)
  height = "200px"
  result = 5
  output = document.getElementById("output")

  html = "#{counter} <img src='propose.png' height=50px /> "
  if rand(100) <= 6.3
    html << "<img src='omiaiok.png' height=#{height} />"
    $status[:omiai_ok] += 1
  else
    html << "<img src='omiaing.png' height=#{height} />"
    result = 1
  end

  if result == 5
    if rand(100) <= 34.0
      html << "<img src='karikousaiok.png' height=#{height} />"
      $status[:karikousai_ok] += 1
    else
      html << "<img src='karikousaing.png' height=#{height} />"
      result = 2
    end
  end

  if result == 5
    if rand(100) <= 9.6
      html << "<img src='sinkenkousaiok.png' height=#{height} />"
      $status[:sinkenkousai_ok] += 1
    else
      html << "<img src='sinkenkousaing.png' height=#{height} />"
      result = 3
    end
  end

  if result == 5
    if rand(100) <= 59.8
      html << "<img src='seikonok.png' height=#{height} />"
      $status[:seikon_ok] += 1
    else
      html << "<img src='seikonng.png' height=#{height} />"
      result = 4
    end
  end

  output[:innerHTML] = "#{html}<br>#{output[:innerHTML]}"
  return result
end

def execute
  counter = 1
  clear_html()
  $status = { omiai_ok: 0, karikousai_ok: 0, sinkenkousai_ok: 0, seikon_ok: 0 }

  render = ->() {
    # clearIntervalの仕方がわからん
    if counter > 1001
      if counter == 1002
        output = document.getElementById("output")
        output[:innerHTML] = "#{$status.inspect}<br><br>#{output[:innerHTML]}"
        counter += 1
      end
      return
    end

    #console_log "loop #{counter}"
    result = propose(counter)
    if result == 5
      counter = 1002
    else
      counter += 1
    end
  }

  # JavascriptのsetIntervalにrenderのprocを渡す
  JS.global.call(:setInterval, JS.try_convert(render), 20)
end

button = document.getElementById('executeButton')

button.addEventListener 'click' do |_e|
  execute()
end
