module Template
  def template(source_template, req_id, alt_options)

    replace_alt_code = format_altcode(req_id, alt_options)

    new_template = replace_word(source_template, '%CODE%', req_id)
    replace_word(new_template, '%ALTCODE%', replace_alt_code)
  end

  private
  # no need to find the index by hand and split the characters
  # accordingly when we can do a simple pattern match with regular exp

  # gsub does all the previous work under the hood in it's implementation

  # this makes our code more reusable and we can alter our matching
  def replace_word(template, replaced_word, new_word)
    template.gsub(/#{replaced_word}/, new_word)
  end
  # we define a private method format altcode if we want to later
  # change our default options for how our altcode is modified

  # this should not be a public interface but an implementation detail
  # we define default options that can quickly be changed and the ability
  # to pass options as we see fit using a hash
  def format_altcode(req_id, options = {})
    dash_entry      = options[:dash_entry]      || default_dash_entry
    alt_code_length = options[:alt_code_length] || default_alt_code_length

    replace_alt_code = req_id[0...dash_entry] + "-" + req_id[dash_entry...alt_code_length]
  end

  def default_dash_entry
    5
  end

  def default_alt_code_length
    8
  end
end
