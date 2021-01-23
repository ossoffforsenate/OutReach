module PhoneNumberUtils
  def self.normalize(phone_number)
    all_digits = phone_number.gsub(/\D/, "")
    while all_digits.length < 10
      all_digits = "0" + all_digits
    end
    all_digits
  end

  def self.display(phone_number)
    return "No phone number given" unless phone_number.present? 
    normalized = normalize(phone_number)
    if normalized.length != 10
      phone_number # don't risk anything weird
    else
      "(#{normalized[0..2]}) #{normalized[3..5]} #{normalized[6..9]}"
    end
  end
end
