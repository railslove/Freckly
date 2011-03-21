module Enumerable
  def to_param(options={})
    escape = options[:escape]
    previous_base = options[:base]
    parts = []

    self.to_a.each do |key, value|
      base = build_base(key, previous_base)

      case value
      when Array
        values = value.map(&:strip).join(",")
        parts << build_param(base, values)
      when Hash
        parts << value.to_param(:escape => false, :base => base)
      else
        parts << (escape ? build_escaped_param(base, value) : build_param(base, value))
      end
    end

    parts.join("&")
  end

  private

  def escape(s)
    s.to_s.gsub(/([^a-zA-Z0-9_.-]+)/n) do
      '%' << $1.unpack('H2'* $1.bytesize).join('%').tap { |c| c.upcase! }
    end
  end

  # {:a => {:b => {:c => "d"}}} => a[b][c]...
  # {:a => {:b => "d"}} => a[b]...
  def build_base(key, previous_base)
    return key unless previous_base

    "#{previous_base}[#{key}]"
  end

  def build_param(base, value)
    "#{base}=#{value}"
  end

  def build_escaped_param(base, value)
    "#{escape(base)}=#{escape(value)}"
  end
end