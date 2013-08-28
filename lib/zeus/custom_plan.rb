require 'zeus/rails'

class CustomPlan < Zeus::Rails

  def guard
    require 'guard/cli'
    Guard::CLI.start
  end

  # def my_custom_command
  #  # see https://github.com/burke/zeus/blob/master/docs/ruby/modifying.md
  # end

end

Zeus.plan = CustomPlan.new
