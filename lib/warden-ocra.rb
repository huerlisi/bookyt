Warden::Manager.serialize_into_session{|user| user.id }
Warden::Manager.serialize_from_session{|id| User.find(id) }

SUITE = 'OCRA-1:HOTP-SHA1-6:QN08'

# add warden strategy
Warden::Strategies.add(:ocra) do
  def valid?
    user = User.find_users(params)
    return false unless user
    puts user.inspect

    user.where("challenge IS NOT NULL").exists?
  end

  def authenticate!
    user = User.find_user(params)
    challenge_hex = user.challenge.to_i.to_s(16)
    response = Rocra.generate(
      SUITE, user.shared_secret, '', challenge_hex, '', '', '')
    params_response = params["user"]["password"]
    response == params_response ? success!(user) : fail!("Cannot log in")
  end
end

Warden::Strategies.add(:ocra_challenge) do
  def valid?
    user = User.find_users(params)
    return false unless user
    puts user.inspect

    user.where("challenge IS NULL").exists?
  end

  def authenticate!
    u = User.generate_challenge! params
    env['warden'].set_user(u)
    pass
  end
end
