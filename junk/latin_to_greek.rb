
          input = message.text.downcase.chars
          latin = 'a b c d e f g h i j k l m n o p q r s t u v w x y z'.split' '
          greek1 = 'α β ς δ ε φ γ η ι ζ κ λ μ η ο π ϙ ρ σ τ υ ν ω χ υ ζ'.split' '


          lat_greek = latin.zip(greek).to_h

          string = ''

          input.each do |letter|
            hash.default = letter
            string += hash[letter]
         