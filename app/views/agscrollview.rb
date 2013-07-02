class AGScrollView < UIScrollView

  def initWithFrame(rect)

    if super
      puts "ScrollView init"
    end

    self

  end

  def shouldAutorotateToInterfaceOrientation(orientation)
    # true if ipad? or orientation != UIInterfaceOrientationPortraitUpsideDown
    orientation != UIInterfaceOrientationPortraitUpsideDown
  end

  def scrollViewDidScroll(scrollView)
    # self.loadVisiblePages
    puts "I just scrolled"
  end

  
  def scrollViewDidEndDecelerating(newScrollView)
    puts "Stopped Scrolling"
    self.scrollViewDidEndScrollingAnimation(newScrollView)
    pageControl.currentPage = currentPage.pageIndex

    # if (currentPage.pageIndex == 0)
    #     scrollView.contentOffset = CGPointMake(320*(pageControl.numberOfPages-2), 0)
    #     pageControl.currentPage = pageControl.numberOfPages-2
    # elsif (currentPage.pageIndex == pageControl.numberOfPages-1)
    #     scrollView.contentOffset = CGPointMake(320, 0)
    #     pageControl.currentPage = 1
    # end

  end

end