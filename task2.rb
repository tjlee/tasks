class LogRecord

  attr_accessor :exec_time
  attr_accessor :response_code
  attr_accessor :response_time_curl
  attr_accessor :response_time_browser
  attr_accessor :request_url
  attr_accessor :response_type

  def initialize(exec_time, response_code, response_time_curl,
      response_time_browser, request_url, response_type)
    @exec_time =exec_time
    @response_code =response_code
    @response_time_curl =response_time_curl
    @response_time_browser=response_time_browser
    @request_url=request_url
    @response_type=response_type
  end

end

class Task2

  def get_top_ten_fast_load_pages(path_to_file, path_to_search="www.somesite/shop/")
    tmp = read_data(path_to_file)
    res = []
    tmp.find_all { |a| a.request_url.to_s.include? path_to_search }.
        sort_by { |el| el.response_time_browser }.
        group_by { |el| el.request_url }.
        each_key { |el| res << el }

    res.slice(0, 10)
  end

  def get_maximum_load_difference(path_to_file)

    read_data(path_to_file).
        sort_by { |item| (item.response_time_browser.to_f - item.response_time_curl.to_f).abs }.
        reverse

  end

  def get_five_percent_maximum_browser_load_time(path_to_file)

    read_data(path_to_file).
        sort_by { |item| item.response_time_browser.to_f }.
        reverse.
        slice(0, lines.size * 5 /100.0)

  end

  def get_average_load_time(path_to_file)

    result = Hash.new()
    grouped_lines = read_data(path_to_file).group_by { |item| item.request_url }

    grouped_lines.each_key {
        |key|
      average_curl = 0
      average_browser = 0

      grouped_lines[key].each {
          |elem|
        average_browser += elem.response_time_browser.to_f/grouped_lines[key].size
        average_curl += elem.response_time_curl.to_f/grouped_lines[key].size
      }

      result[key] = [average_curl, average_browser]
    }

    return result

  end

  private

  def read_data(path_to_file)

    lines_array = []
    File.readlines(path_to_file).map { |line|
      split_result = line.split(", ")
      inst = LogRecord.new(split_result[0], split_result[1], split_result[2],
                           split_result[3], split_result[4], split_result[5])
      lines_array << inst
    }

    lines_array.drop(1)
  end

end
