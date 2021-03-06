module Victor

  # Converts a Hash to a CSS string
  class CSS
    attr_reader :attributes

    def initialize(attributes={})
      @attributes = attributes
    end

    def to_s
      convert_hash attributes
    end

    private

    def convert_hash(hash, indent=2)
      return hash unless hash.is_a? Hash

      result = []
      hash.each do |key, value|
        key = key.to_s.tr '_', '-'
        result += css_block(key, value, indent)
      end

      result.join "\n"
    end

    def css_block(key, value, indent)
      result = []

      my_indent = " " * indent

      if value.is_a? Hash
        result.push "#{my_indent}#{key} {"
        result.push convert_hash(value, indent+2)
        result.push "#{my_indent}}"
      elsif value.is_a? Array
        value.each do |row|
          result.push "#{my_indent}#{key} #{row};"
        end
      else
        result.push "#{my_indent}#{key}: #{value};"
      end

      result
    end
  end

end