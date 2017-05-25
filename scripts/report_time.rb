# coding: utf-8
require 'tempfile'

def run
  speak("现在开始报时")

  previous = nil
  while true
    sleep(1)
    now = Time.now
    t = now.strftime("%Y-%m-%d %H:") + (now.min / 15).to_s
    if t != previous
      speak("现在时刻，北京时间，#{now.hour}点#{now.min}分")
      previous = t
    end
  end
end

def speak(msg)
  Dir::Tmpname.create(['a', '.wav']) do |filename|
    begin
      `echo "#{msg}" | ekho -a 0 -s 0 -p 25 -f - -o #{filename} | mplayer #{filename}`
    ensure
      FileUtils.rm_rf(filename)
    end
  end
end


run
