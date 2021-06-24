module JsonComparison
  def compare_json(json1, json2)
  
    raise TypeError, "Invalid JSON Data" if ((json1.empty? || json1.nil?) && (json2.empty? || json2.nil?))

    result = false

    json1,json2 = [json1,json2].map! do |json|
      json.is_a?(String) ? JSON.parse(json) : json
    end

    if(json1.is_a?(Array))
      json1.each_with_index do |obj, index|
        json1_obj, json2_obj = obj, json2[index]
        result = compare_json(json1_obj, json2_obj)
        break unless result
      end
    elsif(json1.is_a?(Hash))

      json1.each do |key,value|

        return false unless json2.has_key?(key)

        json1_val, json2_val = value, json2[key]

        if(json1_val.is_a?(Array) || json1_val.is_a?(Hash))
          result = compare_json(json1_val, json2_val)
        else
          result = (json1_val == json2_val)
        end

        break unless result
      end
    end

    return result ? true : false
  end
end
