# encoding: UTF-8

module RequestMacros
  def login_admin
    before do
      @admin = Factory.create(:admin)
      post_via_redirect user_session_path, 'user[email]' => @admin.email, 'user[password]' => @admin.password
    end
  end
end
