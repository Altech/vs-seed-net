if window.navigator.standalone
  $ ->
    $("#browsing-nav-in-ios-app").show()

    ## restore the last opened page (not access to top)
    # restore the page
    if document.referrer == '' && localStorage.getItem("lastAccessedURL") != null
      url = localStorage.getItem("lastAccessedURL")
      $.pjax
        url: url
        container: "#pjax-container"
        fragment: "#pjax-container"
        timeout: 1000
    # save the last accessed page
    $(document).on "pjax:send", (xhr, options) ->
      localStorage.setItem("lastAccessedURL",xhr.currentTarget.URL);
    return
