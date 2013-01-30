
class Task1

  def select_test_cases_from_file(pathToFile, limit = 10)

    if limit > 0

      linesArray = File.readlines(pathToFile)

      if linesArray.size > 1 # in case of only header in file presented

        if limit > linesArray.size - 1
          limit = linesArray.size # getting all lines from file
        end

        randomArray = randomize_array_without_zero(limit, linesArray.size)
        resultArray = Array.new()

        for i in randomArray
          if linesArray[i]!=nil
            resultArray << linesArray[i]
            linesArray[i] = nil
          end
        end

        linesArray.delete_if { |element| element == nil }
        write_array_to_file(pathToFile, linesArray)
        write_array_to_file(pathToFile+"_res", resultArray)
      end
    end
  end

  private

  def write_array_to_file(path, array)
    File.open(path, "w") do |file|
      file.puts array
    end
    return path
  end

  def randomize_array_without_zero(length, seed)
    if length <= seed
      res = Array.new(length).map {
          |el| el = 1 + rand(seed)
      }.uniq

      while res.size != length
        res << 1 + rand(seed)
        res.uniq!
      end
      return res
    end
  end

end

