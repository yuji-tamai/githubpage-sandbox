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
def propose(counter)
  output = document.getElementById("output")

  output[:innerHTML] = "#{counter}回目のプロポーズ: "
  if rand(100) <= 6.3
    output[:innerHTML] = "#{output[:innerHTML]}[1ok]"
  else
    output[:innerHTML] = "#{output[:innerHTML]}[1ng]<br>"
    return false
  end

  if rand(100) <= 34.0
    output[:innerHTML] = "#{output[:innerHTML]}[2on]"
  else
    output[:innerHTML] = "#{output[:innerHTML]}[2ng]<br>"
    return false
  end

  if rand(100) <= 9.6
    output[:innerHTML] = "#{output[:innerHTML]}[3ok]"
  else
    output[:innerHTML] = "#{output[:innerHTML]}[3ng]<br>"
    return false
  end

  if rand(100) <= 59.8
    output[:innerHTML] = "#{output[:innerHTML]}[4ok]<br>"
  else
    output[:innerHTML] = "#{output[:innerHTML]}[4ng]<br>"
    return false
  end

  true
end

def execute
  counter = 1
  render = ->() {
    # clearIntervalの仕方がわからん
    return if counter > 101

    clear_html()
    console_log "loop #{counter}"
    if propose(counter)
      counter = 999
    else
      counter += 1
    end
  }

  # JavascriptのsetIntervalにrenderのprocを渡す
  JS.global.call(:setInterval, JS.try_convert(render), 100)
end

button = document.getElementById('executeButton')

button.addEventListener 'click' do |_e|
  execute()
end
