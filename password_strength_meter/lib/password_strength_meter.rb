class PasswordStrengthMeter
	def self.evaluate(username, password)
		puntuacion = 1.0
		if password.match(/[A-Z]/).nil?
			puntuacion -= 0.2
		end

		if password.match(/[a-z]/).nil?
			puntuacion -= 0.2
		end

		if password.match(/[0-9]/).nil?
			puntuacion -= 0.1
		end

		if password.length <= 5
			puntuacion -= 0.3
		end

		if password.length <= 7
			puntuacion -= 0.1
v		end

		similitud = (1.0 - (PasswordStrengthMeter.jaro_winkler(username, password, true) || 0.0))
		similitud = 1.0 if similitud.nil? or similitud.nan?

		puts "Score: #{puntuacion.to_s} Similarity: #{similitud.to_s}"

		evaluacion = (puntuacion * similitud)
		evaluacion = (evaluacion).round(4)
	end

def self.jaro_winkler(str1, str2, winkleradjust=false)
  m = 0
  tr = 0

  s1 = str1.strip.split(//)
  s2 = str2.strip.split(//)

  s1l = s1.length
  s2l = s2.length

  if s1l > s2l
    tmp = s2
    s2 = s1
    s1 = tmp
  end

  found = Hash[*s2.uniq.sort.collect { |v| [v,0]}.flatten]

  md = (([s1l,s2l].max / 2) - 1).to_i

  s1.each_with_index do |c,i|

    if !found[c].nil?
      if !s2.aindices(c)[found[c]].nil?
        x = (s2.aindices(c)[found[c]] - i).abs
        if x <= md 
          found[c] += 1
          m += 1
          if (x != 0)
            tr += 1
          end
        end
      end
    end
  end
  tr = (tr/2).to_i

  third = 1.0/3
  jd = (third * m / s1l) + (third * m / s2l) + (third * (m - tr) / m)
  out = jd

  if winkleradjust
    l = 0
    (0..s1l-1).each { |i| s1[i]==s2[i] ? l+=1 : break }
    out = jd + (l * 0.1 * (1 - jd))
  end

end


end


class String
  def each_char_with_index
    i = 0
    split(//).each do |c|
      yield i, c
      i += 1
    end
  end
end

class Array
   def select_with_index
     index = -1
     select { |x| index += 1; yield(x, index) }
   end

   def aindices(o)
     out = Array.new
     select_with_index { |x, i| 
       out << i if x == o }
      out
   end
end


