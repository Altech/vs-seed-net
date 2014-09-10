if window.navigator.standalone
  $ ->
    $("#browsing-nav-in-ios-app").show()

    ## restore the last opened page (not access to top)
    # restore the page if in savingTime
    savingTime = 60 * 10
    if document.referrer == '' && localStorage.getItem("lastAccessedURL") != null
      time = parseInt(localStorage.getItem("lastAccessedTime"))
      url = localStorage.getItem("lastAccessedURL")
      if Date.now() - time <= savingTime * 1000
        $.pjax
          url: url
          container: "#pjax-container"
          fragment: "#pjax-container"
          timeout: 1000
    # save the last accessed page
    $(document).on "pjax:send", (xhr, options) ->
      localStorage.setItem("lastAccessedURL",xhr.currentTarget.URL);
      localStorage.setItem("lastAccessedTime",Date.now())
    return
