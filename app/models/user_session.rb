class UserSession < Authlogic::Session::Base
  # function to_key used by Authlogic but not defined in Authlogic
  def to_key
    # return nil if this is a new record, otherwise send primary_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end

  def persisted?
    false
  end

end
