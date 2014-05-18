class Hash
  def to_params
    params = ''
    stack = []

    each do |k, v|
      if v.is_a?(Hash)
        stack << [k, v]
      else
        params << "#{k}=#{CGI::escape(v)}&"
      end
    end

    stack.each do |parent, hash|
      hash.each do |k, v|
        if v.is_a?(Hash)
          stack << ["#{parent}[#{k}]", v]
        else
          params << "#{parent}[#{k}]=#{CGI::escape(v)}&"
        end
      end
    end

    params.chop!
    "&#{params}"
  end
end
