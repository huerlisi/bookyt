# Story helpers
#
# This is a collection of helper scripts that allow more semantic story specs.

# Scope to top menu
def within_menu(&block)
  within '.navbar-fixed-top' do
    yield
  end
end

# Navigation helper for menu entries
def navigate_to(menu_steps)
  within_menu do
    menu_steps.split(' / ').each do |step|
      click_on step
    end
  end
end
