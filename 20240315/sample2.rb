# 2) rubyを外部ファイルにする
require 'js'

now = Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')
puts "Hello, world! to console_log #{now}"
output = JS.global[:document].getElementById("output")
output[:innerHTML] = "Hello, world! to html #{now}"
