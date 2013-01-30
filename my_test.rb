require "test/unit"
require "task2"

class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_fail

    task2 = Task2.new
    result = task2.get_top_ten_fast_load_pages("/Users/vasilychernov/RubymineProjects/task1/task2.log2")
    puts result

  end


end