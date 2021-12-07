class TenjiMaker
  Vowels = {
    a: 'o--',
    i: 'o-o',
    u: 'oo-',
    e: 'ooo',
    o: '-oo'
  }

  Consonants = {
    k: '--o',
    s: 'o-o',
    t: 'oo-',
    n: '-o-',
    h: '-oo',
    m: 'ooo',
    r: 'o--',
    y: '-o-',
    w: '---'
  }

  def to_tenji(text)
    chars = text.split(' ')
    tenji_array = chars.map { |char| to_tenji_each_char(char) }

    top, middle, bottom = Array.new(3) { [] }
    tenji_array.each do |t|
      top << t[0, 2]
      middle << t[2, 2]
      bottom << t[4, 2]
    end

    output = {}
    output[:top] = top.join(' ')
    output[:middle] = middle.join(' ')
    output[:bottom] = bottom.join(' ')

    <<~TENJI.chomp
      #{output[:top]}
      #{output[:middle]}
      #{output[:bottom]}
    TENJI
  end

  private

  def to_tenji_each_char(char)
    if char.size == 1
      tenji = ''
      case char
      when 'N'
        tenji = '---ooo'
      else
        tenji = Vowels[char.downcase.to_sym]
      end
      tenji += '---'
    else
      if char[0] == 'Y'
        case char[1]
        when 'A'
          Consonants[char[0].downcase.to_sym] + '-o-'
        when 'U'
          Consonants[char[0].downcase.to_sym] + 'oo-'
        when 'O'
          p Consonants[char[0].downcase.to_sym] + 'oo-'
        end
      elsif char == 'WA'
        '----o-'
      else
        Vowels[char[1].downcase.to_sym] + Consonants[char[0].downcase.to_sym]
      end
    end
  end
end
