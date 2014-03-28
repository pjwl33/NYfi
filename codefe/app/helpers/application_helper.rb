module ApplicationHelper

  def yesno(x)
    x ? "Yes" : "No"
  end

  def onoff(x)
    x ? "Active" : "Offline"
  end

end
