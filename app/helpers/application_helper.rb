module ApplicationHelper
  def popularity(data)
    # data is: { today_count: N, recent_count: M }
    return ''      if data.nil? || data[:recent_count] == 0
    return '|||||' if data[:recent_count] > 27
    return '||||'  if data[:recent_count] > 9
    return '|||'   if data[:recent_count] > 3
    return '||'    if data[:recent_count] > 1
    return '|'     if data[:recent_count] > 0
  end
end
