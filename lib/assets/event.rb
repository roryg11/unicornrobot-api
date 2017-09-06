class Event
  def initialize(title, link, description)
    @title = title
    @link = link
    @description = description
    @short_description = change_description
    @date =  set_date
    @location = set_location
    @speaker = set_speaker
    @jump = set_jump
    @footer_text = footer_text
  end

  def title
    @title
  end

  def link
    @link
  end

  def change_description
    @short_description = "Join #{string_between_markers("Join", "This month's details...", @description)}"
    @short_description
  end

  def set_date
    @date = string_between_markers("When:", "Speaker:", @description)
    @date
  end

  def set_speaker
    @speaker = string_between_markers("Speaker:", "Location:",  @description)
    if !@speaker
      @speaker = string_between_markers("Speaker:", "Jump:",  @description)
      if !@speaker
        @speaker = string_between_markers("Speaker:", "First",  @description)
      end

    end
    @speaker
  end

  def set_location
    @location = string_between_markers("Where:", "When", @description)
    @location
  end

  def set_jump
    @jump = string_between_markers("Jump:", "When", @description)
    if !@jump
      @jump = string_between_markers("Jump:", "First", @description)
      if !@jump
        @jump = string_between_markers("Jump:", "Location", @description)
      end
    end
  end

  def footer_text
    "New to the WTJ scene? Read on for a little more about us... When to Jump™ is a curated global community featuring the individuals, stories, and ideas related to leaving something comfortable in order to pursue a passion. Since its launch in January of 2016, the platform has reached millions of impressions with daily participation from young professionals worldwide at in-person events and across print, digital, and social platforms."
  end

  def string_between_markers(marker1, marker2, string)
    newString = string[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
    newString
  end
end
