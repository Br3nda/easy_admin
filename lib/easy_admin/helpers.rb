module EasyAdmin
  module ViewHelpers
    def clean_params(params)
      if params =~ /\?xml/
        params = Hash.from_xml(params)
      end

      pretty_hash(params)
    end

    def pretty_hash(hash)
      string = ""
      hash.each_pair do |key, value|
        if value.class == Hash
          value = pretty_hash(value)
          string << "[ #{key.to_s.upcase} ]<br/>"
          string << "#{value}"
        else
          string << "<b>#{key.to_s.titlecase}</b> #{value}<br/>"
        end
      end
      string.html_safe
    end
  end
end