module ApplicationHelper
  @@x = 0
  def x_succ
    @@x += 460
  end
  def x_current
    @@x
  end
  # def code
  #   @content = yield
  #   render partial: 'slides/code', locals: {content: "a = 1"}
  # end
end