class	AGPager < UIView

  attr_accessor :views

  def initWithViews(views, andFrame:frame)
    if (super)
      puts "Initialize the Pager"

      @views = []

      self.frame = frame
      self.views = views

      self.scrollViewHeight = frame.size.height
      self.scrollViewWidth = frame.size.width
      # self.userInteractionEnabled = 'YES'

      scrollView.removeFromSuperview
      pageControl.removeFromSuperview

      scrollView = self.scrollView
      pageControl = self.pageControl

      pageCount = self.views.count

      # Set up the array to hold the views for each page
      self.pageViews = []

      # for (i=0, i < pageCount, i++)
      #   self.pageViews.addObject(null)
      # end

      pageCount.times do |p|
        self.pageViews.addObject(NSNull.null)
      end

      # Setup pageControl
      pageControl.currentPage = 0
      pageControl.numberOfPages = pageCount

      # Setup the content size of the scrollView
      contentWidth = scrollView.frame.size.width * self.views.count
      contentHeight = scrollView.frame.size.height

      scrollView.contentSize = CGSizeMake(contentWidth, contentHeight)

      puts "The Scrollable area has a width of #{contentWidth}, #{contentHeight}"

      self.addSubview(scrollView)
      self.addSubview(pageControl)

      # Load the initial set of pages that are on screen
      self.loadVisiblePages

    end

    self
  end

  def scrollView
    scrollView = UIScrollView.alloc.initWithFrame(CGRectMake(0.0, 0.0, self.scrollViewWidth, self.scrollViewHeight))
    scrollView.delegate = self
    scrollView.backgroundColor = UIColor.blueColor
    scrollView.contentSize = CGSizeMake(self.scrollViewWidth, self.scrollViewHeight)
    scrollView.showsHorizontalScrollIndicator = true
    scrollView.userInteractionEnabled = true
    scrollView.pagingEnabled = true
    scrollView
  end

  def pageControl
    pageControlHeight = 44.0 #CGFloat
    pageControl = UIPageControl.alloc.initWithFrame(CGRectMake(0.0, (self.scrollViewHeight - pageControlHeight), self.scrollViewWidth, pageControlHeight))
    pageControl.userInteractionEnabled = true
    pageControl
  end

  def shouldAutorotateToInterfaceOrientation(orientation)
    # true if ipad? or orientation != UIInterfaceOrientationPortraitUpsideDown
    orientation != UIInterfaceOrientationPortraitUpsideDown
  end

  def scrollViewDidScroll(scrollView)
    self.loadVisiblePages
  end

  def loadVisiblePages
    pageWidth = scrollView.frame.size.width #CGFloat
    page = floor((_scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)) #NSInteger

    self.pageControl.currentPage = page

    # Work out which pages we want to load
    firstPage = page - 1
    lastPage = page + 1

    # Purge anything before the first page

    # 0..3  = 0,1,2,3
    # 0...3 = 0,1,2
    (0...firstPage).each do |index|
      self.purgePage(index)
    end

    (firstPage..lastPage).each do |index|
      self.loadPage(index)
    end

    (lastPage+1...self.pageViews.count).each do |index|
      self.purgePage(index)
    end

  end

  def loadPage(page)
    return if (page < 0 || page >= self.pageViews.count)

    pageView = self.pageViews.objectAtIndex(page)

    if (pageView == NSNull.null)

      frame = scrollView.bounds
      frame.origin.x = frame.size.width * page
      frame.origin.y = 0.0

      # Get a UIView from the views array that was set by the controller that inherits from AGPager
      # Set that view's frame to start at the x value that corresponds to this page in the UIScrollView
      viewObject = self.views.objectAtIndex(page)
      viewObject.frame = frame

      # add this View to the UIScrollView and replace the Null in the pageViews array with this view
      scrollView.addSubview(viewObject)
      self.pageViews.replaceObjectAtIndex(page, withObject:viewObject)

    end
  end

  def purgePage(page)
    # If it's outside the range of what we have to display, then do nothing
    return if page < 0 || page >= self.pageViews.count

    # Remove a page from the scroll view and reset the container array
    if (pageView != NSNull.null)
      pageView.removeFromSuperview
      self.pageViews.replaceObjectAtIndex(page, withObject:NSNull.null)
    end
  end





end