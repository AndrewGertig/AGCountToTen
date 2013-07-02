class AGLabel < UILabel


  def initWithFrame(frame)
    # self = super.initWithFrame(frame)

    if (super)
      self.textColor = UIColor.whiteColor
      self.font = UIFont.systemFontOfSize(280)
      self.textAlignment = UITextAlignmentCenter
      self.backgroundColor = UIColor.clearColor
    end

    self
  end


# FROM AccordionView https://github.com/toamitkumar/AccordionView


# OPTIONAL

  # def drawRect(rect)
  #   self.layer.cornerRadius = 4.0
  #   self.layer.borderWidth = 2
  # end

  # def drawTextInRect(rect)
  #   # insets = UIEdgeInsets {0,5,0,5}
  #   # super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
  # end

end