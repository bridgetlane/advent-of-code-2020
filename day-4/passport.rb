
class Passport
  attr_accessor :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

  def initialize(opts)
    @byr           = opts.fetch("byr", nil)
    @iyr           = opts.fetch("iyr", nil)
    @eyr           = opts.fetch("eyr", nil)
    @hgt           = opts.fetch("hgt", nil)
    @hcl           = opts.fetch("hcl", nil)
    @ecl           = opts.fetch("ecl", nil)
    @pid           = opts.fetch("pid", nil)
    @cid           = opts.fetch("cid", nil)
  end

  def valid?
    if byr.nil? || iyr.nil? || eyr.nil? || hgt.nil? || hcl.nil? || ecl.nil? || pid.nil? 
      return false
    end

    if byr.to_i < 1920 || byr.to_i > 2002  
      return false
    end

    if iyr.to_i < 2010 || iyr.to_i > 2020  
      return false
    end

    if eyr.to_i < 2020 || eyr.to_i > 2030  
      return false
    end

    if !hgt.match(/\d+(cm|in)/) 
      return false
    end

    digits, kind = hgt.match(/(\d+)(cm|in)/).captures
    if kind == "cm" && (digits.to_i < 150 || digits.to_i > 193) 
      return false
    end

    if kind == "in" && (digits.to_i < 59 || digits.to_i > 76) 
      return false
    end

    if !hcl.match(/#[0-9a-f]{6}/) 
      return false
    end

    case ecl
    when "amb", "blu", "brn", "gry", "grn", "hzl", "oth"
    else
      return false
    end

    if !pid.match(/^\d{9}$/) 
      return false
    end

    return true

  end
end

def load_passports
  attributes = Hash.new
  count = 0

  File.foreach("input.txt") { |line| 
    if line == "\n" then
      ppt = Passport.new(attributes)
      if ppt.valid? then
        count = count + 1 
      end
      attributes = Hash.new
    end

    line.split.each do |pair|
      vals = pair.split(":")
      if vals.length != 2 then
        raise "Error!"
      end

      attributes.store(vals[0], vals[1])
    end
  }

  ppt = Passport.new(attributes)
  if ppt.valid? then
    count = count + 1 
  end

  puts count
end

load_passports