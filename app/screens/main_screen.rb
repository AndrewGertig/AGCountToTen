class MainScreen < PM::Screen

  def will_appear

    # view cycle: initialize, on_load, will_appear, did_appear, will_disappear, did_disappear
    # will_appear ensures that self.view exists
    # and assigning the block to a variable ensures that your view setup is only called once
    # onload should be used for setting things like the nav bar style and the tab bar icons, etc


    @view_loaded ||= begin
      @views = []
      @numbers = [10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1]
      margin = 0
      scrollViewRect = view.bounds

      @my_scroll_view = AGScrollView.alloc.initWithFrame(scrollViewRect)
      @my_scroll_view.pagingEnabled = true
      @my_scroll_view.delegate = self
      @my_scroll_view.contentSize = CGSizeMake(scrollViewRect.size.width * @numbers.count, scrollViewRect.size.height)
      view.addSubview(@my_scroll_view)

      deviceHeight = view.frame.size.height
      centerScreen = deviceHeight / 2.0
      labelHeight = 260
      labelY = centerScreen - labelHeight / 2.0


      @numbers.each do |num|

        numberLabel = AGLabel.alloc.initWithFrame([[0, labelY], [view.frame.size.width, labelHeight]])
        numberLabel.text = "#{num}"
        # numberLabel.backgroundColor = UIColor.blackColor

        wrapperView = UIView.alloc.initWithFrame(scrollViewRect)

        self.viewColorsForNumber(num, wrapperView:wrapperView, andLabel:numberLabel)

        wrapperView.when_pressed do
          # Opening a modal screen with transition or presentation styles
          open_modal AudioTableScreen.new(nav_bar: true, transition_style: UIModalTransitionStyleFlipHorizontal,
              presentation_style: UIModalPresentationFormSheet)

          # UIView.animateWithDuration(1,
          #   animations:lambda {
          #     # animate
          #     # @view.transform = ...
          #   })

        end
        
        wrapperView.addSubview(numberLabel)
        @my_scroll_view.addSubview(wrapperView)
        # @views.addObject(wrapperView)

        # This is at the end so that the starting X location is updated for the next iteration
        scrollViewRect.origin.x += scrollViewRect.size.width
      end

      # Scroll one page automatically so that we don't see the last page on the left.
      #@my_scroll_view.scrollRectToVisible([[view.frame.size.width, 0],[view.frame.size.width, view.frame.size.height]], animated:false)
      scrollToPage(1)

      self
    end

  end

  # Gets fired because the UIScrollView delegate is set to self, which is the UIViewController
  def scrollViewDidScroll(scrollView)
    # puts "I just scrolled"
  end

  # Gets fired because the UIScrollView delegate is set to self, which is the UIViewController
  def scrollViewDidEndDecelerating(scrollView)

    pageWidth = @my_scroll_view.frame.size.width
    page = ((@my_scroll_view.contentOffset.x - pageWidth / 2) / pageWidth).floor + 1

    # puts "Page = #{page}"

    if (page == 0)
      page = 10
      scrollToPage(10)
    elsif (page == 11)
      page = 1
      scrollToPage(1)
    end

    playPageSound(page)
  end

  def scrollToPage(page)
    x = view.frame.size.width * page
    y = 0
    size = view.frame.size
    @my_scroll_view.scrollRectToVisible([[x, y], size], animated:false)
  end

  def viewColorsForNumber(num, wrapperView:wrapperView, andLabel:numberLabel)
      case num
      when 1
        wrapperView.backgroundColor = UIColor.agLightGreen
      when 2
        wrapperView.backgroundColor = UIColor.agBlue
      when 3
        wrapperView.backgroundColor = UIColor.agOrange
      when 4
        wrapperView.backgroundColor = UIColor.agPurple
      when 5
        wrapperView.backgroundColor = UIColor.agGreen
      when 6
        wrapperView.backgroundColor = UIColor.agRed
      when 7
        wrapperView.backgroundColor = UIColor.agVeryLightBlue
        numberLabel.textColor = UIColor.agDarkBlue
      when 8
        wrapperView.backgroundColor = UIColor.agRedBrown
      when 9
        wrapperView.backgroundColor = UIColor.agPink
      when 10
        wrapperView.backgroundColor = UIColor.agVeryLightGreen
        numberLabel.textColor = UIColor.agDarkGreen

        numberLabel.textAlignment = UITextAlignmentLeft
      else
        puts "Nothing to see here"
      end
  
      true
  end

  def playPageSound(page)
    @fileUrl = FileUrl.new(page)
    if @fileUrl.exists
      @player = Player.new @fileUrl.url
      @player.play
    end
  end

  # Not used yet, stretches image to fit space
  def newImageViewWithImage(paramImage, frame:paramFrame)
    result = UIImageView.alloc.initWithFrame(paramFrame)
    result.contentMode = UIViewContentModeScaleAspectFit
    result.image = paramImage
    result
  end



end